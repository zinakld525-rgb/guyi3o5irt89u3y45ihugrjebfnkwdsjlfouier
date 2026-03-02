
import SwiftUI

struct FishDetailView: View {
    @Environment(CatchStore.self) private var catchStore
    @Environment(\.dismiss) private var dismiss

    let fish: Fish
    @State private var showingAddCatch = false

    private var catchHistory: [CatchRecord] {
        catchStore.getCatches(for: fish.id)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with Fish Icon
                FishDetailHeader(fish: fish, isCaught: catchStore.hasCaught(fish: fish))

                // Quick Stats
                FishQuickStats(fish: fish)
                    .padding(.horizontal)

                // Description
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "About", icon: "info.circle.fill")
                    Text(fish.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Habitat & Season
                HStack(spacing: 16) {
                    InfoCard(
                        icon: "mappin.circle.fill",
                        title: "Habitat",
                        value: fish.habitat,
                        color: .blue
                    )
                    InfoCard(
                        icon: "calendar.circle.fill",
                        title: "Best Season",
                        value: fish.bestSeason,
                        color: .orange
                    )
                }
                .padding(.horizontal)

                // Catch History
                if !catchHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Your Catches", icon: "fish.fill")

                        ForEach(catchHistory) { record in
                            CatchHistoryRow(record: record)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }

                // Recipes
                if !fish.recipes.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Recipes", icon: "fork.knife")

                        ForEach(fish.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRow(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }

                Spacer(minLength: 100)
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddCatch = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showingAddCatch) {
            AddCatchView(preselectedFish: fish)
        }
    }
}

struct FishDetailHeader: View {
    let fish: Fish
    let isCaught: Bool

    var body: some View {
        ZStack {
            fish.category.gradient

            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 120, height: 120)

                    Image(systemName: fish.imageName)
                        .font(.system(size: 60))
                        .foregroundColor(.white)

                    if isCaught {
                        Circle()
                            .stroke(.green, lineWidth: 4)
                            .frame(width: 120, height: 120)
                    }
                }

                VStack(spacing: 8) {
                    Text(fish.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(fish.scientificName)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .italic()

                    HStack(spacing: 12) {
                        RarityBadge(rarity: fish.rarity)

                        HStack(spacing: 4) {
                            Image(systemName: fish.category.icon)
                            Text(fish.category.rawValue)
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.vertical, 30)
        }
        .frame(height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}

struct FishQuickStats: View {
    let fish: Fish

    var body: some View {
        HStack(spacing: 16) {
            StatBox(
                icon: "scalemass.fill",
                value: fish.formattedWeight,
                label: "Avg Weight"
            )
            StatBox(
                icon: "ruler.fill",
                value: fish.formattedLength,
                label: "Avg Length"
            )
            StatBox(
                icon: "fork.knife",
                value: "\(fish.recipes.count)",
                label: "Recipes"
            )
        }
    }
}

struct StatBox: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color(hex: "26d0ce"))

            Text(value)
                .font(.headline)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "26d0ce"))
            Text(title)
                .font(.headline)
        }
    }
}

struct CatchHistoryRow: View {
    let record: CatchRecord

    var body: some View {
        HStack {
            Image(systemName: record.weather.icon)
                .foregroundColor(record.weather.color)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(record.shortDate)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(record.location)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(record.formattedWeight)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(record.formattedLength)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            Image(systemName: "fork.knife")
                .foregroundColor(Color(hex: "26d0ce"))
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                HStack {
                    Label(recipe.formattedTotalTime, systemImage: "clock")
                    DifficultyBadge(difficulty: recipe.difficulty)
                }
                .font(.caption)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationStack {
        FishDetailView(fish: FishData.freshwaterFish[0])
            .environment(CatchStore())
    }
}
