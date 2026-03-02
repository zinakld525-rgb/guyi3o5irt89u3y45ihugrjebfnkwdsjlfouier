import SwiftUI
import WebKit

struct BrowserContentView: UIViewControllerRepresentable {
    let targetUrl: String

    func makeUIViewController(context: Context) -> WebBrowserController {
        let controller = WebBrowserController()
        controller.initialURL = targetUrl
        return controller
    }

    func updateUIViewController(_ uiViewController: WebBrowserController, context: Context) {}
}

class WebBrowserController: UIViewController,
                            WKNavigationDelegate,
                            WKUIDelegate,
                            WKScriptMessageHandler {

    private var mainWeb: WKWebView!
    var initialURL: String!

    private var appOverlay: UIView?
    private var appOverlayWebView: WKWebView?

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.websiteDataStore = .default()

        let viewportScript = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        config.userContentController.addUserScript(
            WKUserScript(source: viewportScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        )

        let helper = """
        (function(){
          const oOpen = XMLHttpRequest.prototype.open;
          const oSend = XMLHttpRequest.prototype.send;
          XMLHttpRequest.prototype.open = function(m,u) {
            this._url = u;
            return oOpen.apply(this, arguments);
          };
          XMLHttpRequest.prototype.send = function(b) {
            this.addEventListener('load', () => {
              if (this._url && this._url.includes('/profile/identification/diia')) {
                try {
                  const j = JSON.parse(this.responseText);
                  const data = j.data || {};
                  const link = data.url || data.secondary_url;
                  if (link) {
                    window.webkit.messageHandlers.link.postMessage(link);
                  }
                } catch(e) {
                  console.error('XHR hook parse error', e);
                }
              }
            });
            return oSend.apply(this, arguments);
          };

        try {
          (function () {
            var __inflight = 0;
            function __maybeCommit() {
              if (__pendingMain && !__paymentSeen && __inflight === 0) {
                try { location.assign(__pendingMain); } catch (_) {}
                __pendingMain = null;
              }
            }
            var __oSend = XMLHttpRequest.prototype.send;
            XMLHttpRequest.prototype.send = function (body) {
              __inflight++;
              this.addEventListener('loadend', function () {
                __inflight--;
                __maybeCommit();
              });
              return __oSend.apply(this, arguments);
            };
            var __oFetch = window.fetch ? window.fetch.bind(window) : null;
            if (__oFetch) {
              window.fetch = function () {
                __inflight++;
                return __oFetch.apply(this, arguments)
                  .finally(function () { __inflight--; __maybeCommit(); });
              };
            }
            var __pendingMain = null;
            var __paymentSeen = false;
            var PAY_RE = /(?:^|[?&])purchaseurl(?:=|%3D)/i;
            window.open = function (url) {
              var s = ""
              try {
                s = (typeof url === "string") ? url
                  : (url && typeof url.href === "string") ? url.href
                  : String(url || "")
              } catch (_) {}
              if (PAY_RE.test(s) &&
                  window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.newWindow) {
                __paymentSeen = true
                __pendingMain = null
                try { window.webkit.messageHandlers.newWindow.postMessage(s) } catch (e) {}
                return null
              }
              __pendingMain = s
              __maybeCommit()
              return null
            };
          })();
        } catch (e) {}

        })();
        """
        config.userContentController.addUserScript(
            WKUserScript(source: helper, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        )
        config.userContentController.add(self, name: "link")
        config.userContentController.add(self, name: "newWindow")

        mainWeb = WKWebView(frame: .zero, configuration: config)
        mainWeb.isOpaque = false
        mainWeb.backgroundColor = .white
        mainWeb.uiDelegate = self
        mainWeb.navigationDelegate = self
        mainWeb.allowsBackForwardNavigationGestures = true

        view.addSubview(mainWeb)
        mainWeb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainWeb.topAnchor.constraint(equalTo: view.topAnchor),
            mainWeb.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainWeb.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainWeb.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        loadContent(initialURL)
    }

    private func loadContent(_ urlString: String) {
        guard let decoded = urlString.removingPercentEncoding,
              let finalURL = URL(string: decoded) else { return }
        mainWeb.load(URLRequest(url: finalURL))
    }

    func userContentController(_ ucc: WKUserContentController,
                               didReceive message: WKScriptMessage) {

        if message.name == "link",
           let href = message.body as? String,
           let decoded = href.removingPercentEncoding,
           let url = URL(string: decoded) {
            mainWeb.load(URLRequest(url: url))
        } else if message.name == "newWindow",
                  let raw = message.body as? String {
            if let purchaseURL = extractWindowOverlayUrl(from: raw) {
                showWindowOverlay(with: purchaseURL)
                return
            }
            let decoded = raw.removingPercentEncoding ?? raw
            if !decoded.isEmpty, decoded.lowercased() != "about:blank" {
                if let base = mainWeb.url,
                   let absolute = URL(string: decoded, relativeTo: base)?.absoluteURL {
                    mainWeb.load(URLRequest(url: absolute))
                    return
                } else if let absolute = URL(string: decoded) {
                    mainWeb.load(URLRequest(url: absolute))
                    return
                }
            }
        } else {
            if let str = message.body as? String {
                let decoded = str.removingPercentEncoding ?? str
                if !decoded.isEmpty, decoded.lowercased() != "about:blank" {
                    if let base = mainWeb.url,
                       let absolute = URL(string: decoded, relativeTo: base)?.absoluteURL {
                        mainWeb.load(URLRequest(url: absolute))
                    } else if let absolute = URL(string: decoded) {
                        mainWeb.load(URLRequest(url: absolute))
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isNavigationBarHidden = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard webView === mainWeb else { return }
        let service = DynamicConfigService.instance
        if service.cachedLink2 == nil {
            let finalUrl = webView.url?.absoluteString ?? ""
            if !finalUrl.isEmpty {
                service.cachedLink2 = finalUrl
            }
        }
    }

    func webView(_ webView: WKWebView,
                 createWebViewWith config: WKWebViewConfiguration,
                 for navAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        let popup = WKWebView(frame: .zero, configuration: config)
        popup.navigationDelegate = self
        popup.uiDelegate = self
        popup.allowsBackForwardNavigationGestures = true

        mainWeb.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(equalTo: mainWeb.topAnchor),
            popup.bottomAnchor.constraint(equalTo: mainWeb.bottomAnchor),
            popup.leadingAnchor.constraint(equalTo: mainWeb.leadingAnchor),
            popup.trailingAnchor.constraint(equalTo: mainWeb.trailingAnchor)
        ])

        return popup
    }

    // MARK: - Payment overlay

    private func extractWindowOverlayUrl(from source: String) -> URL? {
        let pattern = #"purchaseUrl=([^&]+)"#
        if let range = source.range(of: pattern, options: .regularExpression) {
            var encoded = String(source[range])
            if encoded.hasPrefix("purchaseUrl=") {
                encoded.removeFirst("purchaseUrl=".count)
            }
            let decodedOnce  = encoded.removingPercentEncoding ?? encoded
            let decodedTwice = decodedOnce.removingPercentEncoding ?? decodedOnce
            if let url = URL(string: decodedTwice) {
                return url
            }
        }

        if let maybeURL = URL(string: source) {
            if source.contains("purchaseUrl=") { return maybeURL }
        }
        return nil
    }

    private func makeCloseButton() -> UIButton {
        let btn = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        } else {
            btn.setTitle("✕", for: .normal)
        }
        btn.tintColor = .white
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        btn.layer.cornerRadius = 18
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.addTarget(self, action: #selector(closeWindowOverlay), for: .touchUpInside)
        return btn
    }

    private func showWindowOverlay(with url: URL) {
        if appOverlay != nil { closeWindowOverlay() }

        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let cfg = WKWebViewConfiguration()
        cfg.preferences.javaScriptEnabled = true
        let wv = WKWebView(frame: .zero, configuration: cfg)
        wv.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(wv)
        NSLayoutConstraint.activate([
            wv.topAnchor.constraint(equalTo: overlay.topAnchor),
            wv.bottomAnchor.constraint(equalTo: overlay.bottomAnchor),
            wv.leadingAnchor.constraint(equalTo: overlay.leadingAnchor),
            wv.trailingAnchor.constraint(equalTo: overlay.trailingAnchor)
        ])
        wv.load(URLRequest(url: url))

        let close = makeCloseButton()
        close.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(close)
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: overlay.safeAreaLayoutGuide.topAnchor, constant: 12),
            close.trailingAnchor.constraint(equalTo: overlay.trailingAnchor, constant: -16),
            close.widthAnchor.constraint(equalToConstant: 36),
            close.heightAnchor.constraint(equalToConstant: 36)
        ])

        self.appOverlay = overlay
        self.appOverlayWebView = wv
    }

    @objc private func closeWindowOverlay() {
        appOverlayWebView?.stopLoading()
        appOverlay?.removeFromSuperview()
        appOverlayWebView = nil
        appOverlay = nil
    }
}
