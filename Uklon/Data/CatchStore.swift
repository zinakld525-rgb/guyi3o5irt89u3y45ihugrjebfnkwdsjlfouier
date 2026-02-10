
import SwiftUI
import Observation

@Observable
class CatchStore {
    private(set) var catches: [CatchRecord] = []
    private(set) var achievements: [Achievement] = Achievement.allAchievements
    private(set) var viewedRecipes: Set<UUID> = []

    private let catchesKey = "savedCatches"
    private let achievementsKey = "savedAchievements"
    private let viewedRecipesKey = "viewedRecipes"

    init() {
        loadData()
    }

    // MARK: - Catch Management

    func addCatch(_ catchRecord: CatchRecord) {
        catches.insert(catchRecord, at: 0)
        saveData()
        updateAchievements(for: catchRecord)
    }

    func deleteCatch(_ catchRecord: CatchRecord) {
        catches.removeAll { $0.id == catchRecord.id }
        saveData()
    }

    func deleteCatches(at offsets: IndexSet) {
        catches.remove(atOffsets: offsets)
        saveData()
    }

    func getCatches(for fishId: UUID) -> [CatchRecord] {
        catches.filter { $0.fishId == fishId }
    }

    func hasCaught(fish: Fish) -> Bool {
        catches.contains { $0.fishId == fish.id }
    }

    func getCaughtFishIds() -> Set<UUID> {
        Set(catches.map { $0.fishId })
    }

    func getUniqueFishCount() -> Int {
        getCaughtFishIds().count
    }

    func getTotalCatchCount() -> Int {
        catches.count
    }

    // MARK: - Statistics

    func getBiggestCatch() -> CatchRecord? {
        catches.max(by: { $0.weight < $1.weight })
    }

    func getLongestCatch() -> CatchRecord? {
        catches.max(by: { $0.length < $1.length })
    }

    func getCatchesByCategory() -> [FishCategory: Int] {
        var result: [FishCategory: Int] = [:]
        let caughtFishIds = getCaughtFishIds()

        for category in FishCategory.allCases {
            let fishInCategory = FishData.allFish.filter { $0.category == category }
            let caughtInCategory = fishInCategory.filter { caughtFishIds.contains($0.id) }
            result[category] = caughtInCategory.count
        }

        return result
    }

    func getCatchesByMonth() -> [(month: String, count: Int)] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"

        var monthCounts: [Int: Int] = [:]

        for catchRecord in catches {
            let month = calendar.component(.month, from: catchRecord.date)
            monthCounts[month, default: 0] += 1
        }

        return (1...12).map { month in
            let date = calendar.date(from: DateComponents(month: month))!
            return (formatter.string(from: date), monthCounts[month] ?? 0)
        }
    }

    func getCatchesByWeather() -> [Weather: Int] {
        var result: [Weather: Int] = [:]
        for weather in Weather.allCases {
            result[weather] = catches.filter { $0.weather == weather }.count
        }
        return result
    }

    func getRecentCatches(limit: Int = 5) -> [CatchRecord] {
        Array(catches.prefix(limit))
    }

    func getTotalWeight() -> Double {
        catches.reduce(0) { $0 + $1.weight }
    }

    // MARK: - Recipe Tracking

    func markRecipeAsViewed(_ recipe: Recipe) {
        viewedRecipes.insert(recipe.id)
        saveViewedRecipes()
        checkRecipeAchievement()
    }

    func hasViewedRecipe(_ recipe: Recipe) -> Bool {
        viewedRecipes.contains(recipe.id)
    }

    // MARK: - Achievement Management

    private func updateAchievements(for catchRecord: CatchRecord) {
        let fish = FishData.allFish.first { $0.id == catchRecord.fishId }

        // Total catches achievements
        updateAchievementProgress(type: .totalCatches, progress: catches.count)

        // Unique fish achievements
        updateAchievementProgress(type: .uniqueFish, progress: getUniqueFishCount())

        // Big catch achievements
        if catchRecord.weight >= 10 {
            updateAchievementProgress(id: "big_game", progress: Int(catchRecord.weight))
        }
        if catchRecord.weight >= 50 {
            updateAchievementProgress(id: "monster_catch", progress: Int(catchRecord.weight))
        }

        // Rare catch achievement
        if let fish = fish, fish.rarity == .legendary {
            updateAchievementProgress(id: "rare_hunter", progress: 1)
        }

        // Category achievements
        for category in FishCategory.allCases {
            let caughtInCategory = getCaughtFishIds().filter { fishId in
                FishData.allFish.first { $0.id == fishId }?.category == category
            }.count
            updateCategoryAchievement(category: category, progress: caughtInCategory)
        }

        saveAchievements()
    }

    private func updateAchievementProgress(type: AchievementType, progress: Int) {
        for i in 0..<achievements.count {
            if achievements[i].type == type {
                achievements[i].progress = max(achievements[i].progress, progress)
                if achievements[i].progress >= achievements[i].requirement {
                    achievements[i].isUnlocked = true
                }
            }
        }
    }

    private func updateAchievementProgress(id: String, progress: Int) {
        if let index = achievements.firstIndex(where: { $0.id == id }) {
            achievements[index].progress = max(achievements[index].progress, progress)
            if achievements[index].progress >= achievements[index].requirement {
                achievements[index].isUnlocked = true
            }
        }
    }

    private func updateCategoryAchievement(category: FishCategory, progress: Int) {
        let achievementId = "\(category.rawValue.lowercased())_pro"
        if let index = achievements.firstIndex(where: { $0.id == achievementId }) {
            achievements[index].progress = progress
            if achievements[index].progress >= achievements[index].requirement {
                achievements[index].isUnlocked = true
            }
        }
    }

    private func checkRecipeAchievement() {
        updateAchievementProgress(id: "recipe_master", progress: viewedRecipes.count)
        saveAchievements()
    }

    func getUnlockedAchievements() -> [Achievement] {
        achievements.filter { $0.isUnlocked }
    }

    func getLockedAchievements() -> [Achievement] {
        achievements.filter { !$0.isUnlocked }
    }

    // MARK: - Persistence

    private func saveData() {
        if let encoded = try? JSONEncoder().encode(catches) {
            UserDefaults.standard.set(encoded, forKey: catchesKey)
        }
    }

    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: catchesKey),
           let decoded = try? JSONDecoder().decode([CatchRecord].self, from: data) {
            catches = decoded
        }

        if let data = UserDefaults.standard.data(forKey: achievementsKey),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: data) {
            achievements = decoded
        }

        if let data = UserDefaults.standard.data(forKey: viewedRecipesKey),
           let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            viewedRecipes = decoded
        }
    }

    private func saveAchievements() {
        if let encoded = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encoded, forKey: achievementsKey)
        }
    }

    private func saveViewedRecipes() {
        if let encoded = try? JSONEncoder().encode(viewedRecipes) {
            UserDefaults.standard.set(encoded, forKey: viewedRecipesKey)
        }
    }

    // MARK: - Helper Methods

    func getFish(by id: UUID) -> Fish? {
        FishData.allFish.first { $0.id == id }
    }

    func getAllRecipes() -> [Recipe] {
        FishData.allFish.flatMap { $0.recipes }
    }

    func getRecipes(for category: FishCategory) -> [Recipe] {
        FishData.allFish
            .filter { $0.category == category }
            .flatMap { $0.recipes }
    }
}
