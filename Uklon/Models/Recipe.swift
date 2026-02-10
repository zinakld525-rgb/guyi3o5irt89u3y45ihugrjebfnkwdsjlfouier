import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let ingredients: [String]
    let instructions: [String]
    let preparationTime: Int
    let cookingTime: Int
    let difficulty: Difficulty
    let servings: Int
    let fishName: String

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        ingredients: [String],
        instructions: [String],
        preparationTime: Int,
        cookingTime: Int,
        difficulty: Difficulty,
        servings: Int,
        fishName: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.preparationTime = preparationTime
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.servings = servings
        self.fishName = fishName
    }

    var totalTime: Int {
        preparationTime + cookingTime
    }

    var formattedTotalTime: String {
        if totalTime >= 60 {
            let hours = totalTime / 60
            let mins = totalTime % 60
            return mins > 0 ? "\(hours)h \(mins)m" : "\(hours)h"
        }
        return "\(totalTime) min"
    }

    var formattedPrepTime: String {
        "\(preparationTime) min"
    }

    var formattedCookTime: String {
        "\(cookingTime) min"
    }
}
