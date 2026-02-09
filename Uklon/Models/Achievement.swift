import SwiftUI

enum AchievementType: String, Codable {
    case totalCatches
    case uniqueFish
    case categoryComplete
    case bigCatch
    case rareCatch
    case recipeViews
}

struct Achievement: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let iconName: String
    let requirement: Int
    let type: AchievementType
    var isUnlocked: Bool
    var progress: Int
    let category: FishCategory?

    init(
        id: String,
        name: String,
        description: String,
        iconName: String,
        requirement: Int,
        type: AchievementType,
        isUnlocked: Bool = false,
        progress: Int = 0,
        category: FishCategory? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.iconName = iconName
        self.requirement = requirement
        self.type = type
        self.isUnlocked = isUnlocked
        self.progress = progress
        self.category = category
    }

    var progressPercentage: Double {
        min(Double(progress) / Double(requirement), 1.0)
    }

    var progressText: String {
        "\(min(progress, requirement))/\(requirement)"
    }

    var color: Color {
        if isUnlocked {
            return .yellow
        }
        return .gray
    }

    static let allAchievements: [Achievement] = [
        Achievement(
            id: "first_catch",
            name: "First Catch",
            description: "Catch your first fish",
            iconName: "fish.fill",
            requirement: 1,
            type: .totalCatches
        ),
        Achievement(
            id: "collector_10",
            name: "Collector",
            description: "Catch 10 different species",
            iconName: "rectangle.stack.fill",
            requirement: 10,
            type: .uniqueFish
        ),
        Achievement(
            id: "collector_50",
            name: "Expert Collector",
            description: "Catch 50 different species",
            iconName: "books.vertical.fill",
            requirement: 50,
            type: .uniqueFish
        ),
        Achievement(
            id: "collector_100",
            name: "Master Collector",
            description: "Catch all 100 species",
            iconName: "crown.fill",
            requirement: 100,
            type: .uniqueFish
        ),
        Achievement(
            id: "freshwater_pro",
            name: "Freshwater Pro",
            description: "Catch all freshwater fish",
            iconName: "drop.fill",
            requirement: 20,
            type: .categoryComplete,
            category: .freshwater
        ),
        Achievement(
            id: "saltwater_pro",
            name: "Saltwater Pro",
            description: "Catch all saltwater fish",
            iconName: "water.waves",
            requirement: 20,
            type: .categoryComplete,
            category: .saltwater
        ),
        Achievement(
            id: "tropical_pro",
            name: "Tropical Pro",
            description: "Catch all tropical fish",
            iconName: "sun.max.fill",
            requirement: 20,
            type: .categoryComplete,
            category: .tropical
        ),
        Achievement(
            id: "arctic_pro",
            name: "Arctic Pro",
            description: "Catch all arctic fish",
            iconName: "snowflake",
            requirement: 20,
            type: .categoryComplete,
            category: .arctic
        ),
        Achievement(
            id: "brackish_pro",
            name: "Brackish Pro",
            description: "Catch all brackish fish",
            iconName: "arrow.left.arrow.right",
            requirement: 20,
            type: .categoryComplete,
            category: .brackish
        ),
        Achievement(
            id: "big_game",
            name: "Big Game",
            description: "Catch a fish over 10kg",
            iconName: "scalemass.fill",
            requirement: 10,
            type: .bigCatch
        ),
        Achievement(
            id: "monster_catch",
            name: "Monster Catch",
            description: "Catch a fish over 50kg",
            iconName: "star.circle.fill",
            requirement: 50,
            type: .bigCatch
        ),
        Achievement(
            id: "frequent_fisher_50",
            name: "Frequent Fisher",
            description: "Log 50 catches",
            iconName: "figure.fishing",
            requirement: 50,
            type: .totalCatches
        ),
        Achievement(
            id: "dedicated_angler",
            name: "Dedicated Angler",
            description: "Log 100 catches",
            iconName: "medal.fill",
            requirement: 100,
            type: .totalCatches
        ),
        Achievement(
            id: "rare_hunter",
            name: "Rare Hunter",
            description: "Catch a legendary fish",
            iconName: "sparkles",
            requirement: 1,
            type: .rareCatch
        ),
        Achievement(
            id: "recipe_master",
            name: "Recipe Master",
            description: "View 50 different recipes",
            iconName: "fork.knife",
            requirement: 50,
            type: .recipeViews
        )
    ]
}
