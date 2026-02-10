
import SwiftUI

struct FishCollectionView: View {
    @Environment(CatchStore.self) private var catchStore
    @State private var selectedCategory: FishCategory? = nil
    @State private var searchText = ""
    @State private var showCaughtOnly = false

    private var filteredFish: [Fish] {
        var fish = FishData.allFish

        if let category = selectedCategory {
            fish = fish.filter { $0.category == category }
        }

        if !searchText.isEmpty {
            fish = fish.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.scientificName.localizedCaseInsensitiveContains(searchText)
            }
        }

        if showCaughtOnly {
            let caughtIds = catchStore.getCaughtFishIds()
            fish = fish.filter { caughtIds.contains($0.id) }
        }

        return fish
    }

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150), spacing: 16)]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                OceanGradient()

                VStack(spacing: 0) {
                    // Header Stats
                    CollectionHeader(
                        totalFish: FishData.allFish.count,
                        caughtFish: catchStore.getUniqueFishCount()
                    )
                    .padding()

                    // Category Filter
                    CategoryPicker(selectedCategory: $selectedCategory)
                        .padding(.bottom)

                    // Fish Grid
                    ScrollView {
                        if filteredFish.isEmpty {
                            ContentUnavailableView(
                                "No Fish Found",
                                systemImage: "fish",
                                description: Text("Try adjusting your filters")
                            )
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        } else {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredFish) { fish in
                                    NavigationLink(destination: FishDetailView(fish: fish)) {
                                        FishCard(
                                            fish: fish,
                                            isCaught: catchStore.hasCaught(fish: fish)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search fish...")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Fish Collection")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            showCaughtOnly.toggle()
                        }
                    } label: {
                        Image(systemName: showCaughtOnly ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(showCaughtOnly ? .green : .white)
                    }
                }
            }
        }
    }
}

struct CollectionHeader: View {
    let totalFish: Int
    let caughtFish: Int

    private var progress: Double {
        guard totalFish > 0 else { return 0 }
        return Double(caughtFish) / Double(totalFish)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Collection Progress")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(caughtFish) of \(totalFish) species caught")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.3))
                        .frame(height: 10)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 10)
                }
            }
            .frame(height: 10)
        }
        .padding()
        .glassCard()
    }
}

#Preview {
    FishCollectionView()
        .environment(CatchStore())
}
