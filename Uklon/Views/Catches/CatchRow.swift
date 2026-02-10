
import SwiftUI

struct CatchRow: View {
    let record: CatchRecord
    let fish: Fish?

    var body: some View {
        HStack(spacing: 16) {
            // Fish Icon
            ZStack {
                if let fish = fish {
                    fish.category.gradient
                } else {
                    Color.gray
                }

                Image(systemName: fish?.imageName ?? "fish.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Catch Details
            VStack(alignment: .leading, spacing: 4) {
                Text(fish?.name ?? "Unknown Fish")
                    .font(.headline)

                HStack(spacing: 12) {
                    Label(record.formattedWeight, systemImage: "scalemass")
                    Label(record.formattedLength, systemImage: "ruler")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                HStack(spacing: 8) {
                    Image(systemName: record.weather.icon)
                        .foregroundColor(record.weather.color)
                    Text(record.location)
                        .lineLimit(1)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()

            // Date
            VStack(alignment: .trailing, spacing: 4) {
                Text(record.shortDate)
                    .font(.caption)
                    .foregroundColor(.secondary)

                if let photo = record.photoData, let uiImage = UIImage(data: photo) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct EmptyCatchesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "fish")
                .font(.system(size: 60))
                .foregroundColor(.white.opacity(0.5))

            Text("No Catches Yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            Text("Tap the + button to log your first catch!")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
}

#Preview {
    VStack {
        CatchRow(
            record: CatchRecord(
                fishId: FishData.freshwaterFish[0].id,
                location: "Lake Michigan",
                weight: 2.5,
                length: 45,
                weather: .sunny
            ),
            fish: FishData.freshwaterFish[0]
        )
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
