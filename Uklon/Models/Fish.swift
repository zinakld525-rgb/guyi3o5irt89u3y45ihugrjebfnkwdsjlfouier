import Foundation

struct Fish: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let scientificName: String
    let description: String
    let category: FishCategory
    let imageName: String
    let averageWeight: Double
    let averageLength: Double
    let rarity: FishRarity
    let habitat: String
    let bestSeason: String
    let recipes: [Recipe]

    init(
        id: UUID = UUID(),
        name: String,
        scientificName: String,
        description: String,
        category: FishCategory,
        imageName: String,
        averageWeight: Double,
        averageLength: Double,
        rarity: FishRarity,
        habitat: String,
        bestSeason: String,
        recipes: [Recipe] = []
    ) {
        self.id = id
        self.name = name
        self.scientificName = scientificName
        self.description = description
        self.category = category
        self.imageName = imageName
        self.averageWeight = averageWeight
        self.averageLength = averageLength
        self.rarity = rarity
        self.habitat = habitat
        self.bestSeason = bestSeason
        self.recipes = recipes
    }

    var formattedWeight: String {
        if averageWeight >= 1 {
            return String(format: "%.1f kg", averageWeight)
        } else {
            return String(format: "%.0f g", averageWeight * 1000)
        }
    }

    var formattedLength: String {
        if averageLength >= 100 {
            return String(format: "%.1f m", averageLength / 100)
        } else {
            return String(format: "%.0f cm", averageLength)
        }
    }
}
