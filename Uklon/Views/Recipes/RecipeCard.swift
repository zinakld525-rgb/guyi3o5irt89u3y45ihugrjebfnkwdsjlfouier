
import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundColor(Color(hex: "26d0ce"))
                    .frame(width: 44, height: 44)
                    .background(Color(hex: "26d0ce").opacity(0.1))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name)
                        .font(.headline)
                        .lineLimit(2)
                    Text(recipe.fishName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                DifficultyBadge(difficulty: recipe.difficulty)
            }

            // Description
            Text(recipe.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            // Stats
            HStack(spacing: 16) {
                Label(recipe.formattedTotalTime, systemImage: "clock")
                Label("\(recipe.servings) servings", systemImage: "person.2")
                Label("\(recipe.ingredients.count) items", systemImage: "list.bullet")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct RecipeCardCompact: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "fork.knife")
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                HStack(spacing: 8) {
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
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct RecipeGridCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(spacing: 0) {
            // Icon Area
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Image(systemName: "fork.knife")
                    .font(.system(size: 36))
                    .foregroundColor(.white)

                VStack {
                    Spacer()
                    HStack {
                        DifficultyBadge(difficulty: recipe.difficulty)
                            .scaleEffect(0.85)
                        Spacer()
                    }
                    .padding(8)
                }
            }
            .frame(height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.system(size: 13, weight: .semibold))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                    Text(recipe.formattedTotalTime)
                        .font(.system(size: 10))
                }
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 20) {
        RecipeCard(recipe: FishData.freshwaterFish[0].recipes[0])
            .padding(.horizontal)

        RecipeCardCompact(recipe: FishData.freshwaterFish[0].recipes[0])
            .padding(.horizontal)

        HStack {
            RecipeGridCard(recipe: FishData.freshwaterFish[0].recipes[0])
            RecipeGridCard(recipe: FishData.saltwaterFish[0].recipes[0])
        }
        .padding(.horizontal)
    }
    .padding(.vertical)
    .background(Color(.systemGroupedBackground))
}
