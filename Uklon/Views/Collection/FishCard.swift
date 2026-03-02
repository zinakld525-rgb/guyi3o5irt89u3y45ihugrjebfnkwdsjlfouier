
import SwiftUI

struct FishCard: View {
    let fish: Fish
    let isCaught: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Fish Image Area
            ZStack {
                fish.category.gradient
                    .opacity(isCaught ? 1 : 0.3)

                Image(systemName: fish.imageName)
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(isCaught ? 1 : 0.5))

                // Caught indicator
                if isCaught {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .background(Circle().fill(.white).padding(2))
                                .offset(x: -5, y: 5)
                        }
                        Spacer()
                    }
                }

                // Rarity indicator
                VStack {
                    Spacer()
                    HStack {
                        RarityBadge(rarity: fish.rarity)
                            .scaleEffect(0.8)
                        Spacer()
                    }
                    .padding(8)
                }
            }
            .frame(height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            // Fish Info
            VStack(alignment: .leading, spacing: 4) {
                Text(fish.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isCaught ? .primary : .secondary)
                    .lineLimit(1)

                HStack {
                    Image(systemName: fish.category.icon)
                        .font(.system(size: 10))
                    Text(fish.category.rawValue)
                        .font(.system(size: 10))
                }
                .foregroundColor(fish.category.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .opacity(isCaught ? 1 : 0.7)
    }
}

struct FishCardLarge: View {
    let fish: Fish
    let isCaught: Bool
    let catchCount: Int

    var body: some View {
        HStack(spacing: 16) {
            // Fish Icon
            ZStack {
                fish.category.gradient

                Image(systemName: fish.imageName)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Fish Details
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(fish.name)
                        .font(.headline)
                    Spacer()
                    RarityBadge(rarity: fish.rarity)
                }

                Text(fish.scientificName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()

                HStack(spacing: 16) {
                    Label(fish.formattedWeight, systemImage: "scalemass")
                    Label(fish.formattedLength, systemImage: "ruler")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                if isCaught {
                    Text("Caught \(catchCount) time\(catchCount == 1 ? "" : "s")")
                        .font(.caption)
                        .foregroundColor(.green)
                        .fontWeight(.medium)
                }
            }

            if isCaught {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack {
            FishCard(fish: FishData.freshwaterFish[0], isCaught: true)
            FishCard(fish: FishData.saltwaterFish[0], isCaught: false)
        }
        .padding()

        FishCardLarge(
            fish: FishData.freshwaterFish[0],
            isCaught: true,
            catchCount: 3
        )
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
