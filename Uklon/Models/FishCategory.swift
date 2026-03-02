import SwiftUI

enum FishCategory: String, CaseIterable, Codable, Identifiable {
    case freshwater = "Freshwater"
    case saltwater = "Saltwater"
    case tropical = "Tropical"
    case arctic = "Arctic"
    case brackish = "Brackish"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .freshwater: return "drop.fill"
        case .saltwater: return "water.waves"
        case .tropical: return "sun.max.fill"
        case .arctic: return "snowflake"
        case .brackish: return "arrow.left.arrow.right"
        }
    }

    var color: Color {
        switch self {
        case .freshwater: return .blue
        case .saltwater: return .cyan
        case .tropical: return .orange
        case .arctic: return .indigo
        case .brackish: return .teal
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .freshwater:
            return LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .saltwater:
            return LinearGradient(colors: [.cyan, .blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .tropical:
            return LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .arctic:
            return LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .brackish:
            return LinearGradient(colors: [.teal, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var description: String {
        switch self {
        case .freshwater:
            return "Fish found in rivers, lakes, and streams"
        case .saltwater:
            return "Ocean and sea dwelling fish"
        case .tropical:
            return "Warm water fish from tropical regions"
        case .arctic:
            return "Cold water fish from northern regions"
        case .brackish:
            return "Fish found where fresh and salt water meet"
        }
    }
}

enum FishRarity: String, CaseIterable, Codable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case legendary = "Legendary"

    var color: Color {
        switch self {
        case .common: return .gray
        case .uncommon: return .green
        case .rare: return .blue
        case .legendary: return .orange
        }
    }

    var stars: Int {
        switch self {
        case .common: return 1
        case .uncommon: return 2
        case .rare: return 3
        case .legendary: return 4
        }
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"

    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

    var icon: String {
        switch self {
        case .easy: return "1.circle.fill"
        case .medium: return "2.circle.fill"
        case .hard: return "3.circle.fill"
        }
    }
}

enum Weather: String, CaseIterable, Codable, Identifiable {
    case sunny = "Sunny"
    case cloudy = "Cloudy"
    case rainy = "Rainy"
    case stormy = "Stormy"
    case foggy = "Foggy"
    case snowy = "Snowy"
    case windy = "Windy"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .stormy: return "cloud.bolt.rain.fill"
        case .foggy: return "cloud.fog.fill"
        case .snowy: return "snow"
        case .windy: return "wind"
        }
    }

    var color: Color {
        switch self {
        case .sunny: return .yellow
        case .cloudy: return .gray
        case .rainy: return .blue
        case .stormy: return .purple
        case .foggy: return .gray.opacity(0.7)
        case .snowy: return .cyan
        case .windy: return .teal
        }
    }
}
