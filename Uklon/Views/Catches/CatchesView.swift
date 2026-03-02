
import SwiftUI

struct CatchesView: View {
    @Environment(CatchStore.self) private var catchStore
    @State private var showingAddCatch = false
    @State private var selectedCategory: FishCategory? = nil
    @State private var searchText = ""

    private var filteredCatches: [CatchRecord] {
        var catches = catchStore.catches

        if let category = selectedCategory {
            catches = catches.filter { record in
                if let fish = catchStore.getFish(by: record.fishId) {
                    return fish.category == category
                }
                return false
            }
        }

        if !searchText.isEmpty {
            catches = catches.filter { record in
                if let fish = catchStore.getFish(by: record.fishId) {
                    return fish.name.localizedCaseInsensitiveContains(searchText) ||
                           record.location.localizedCaseInsensitiveContains(searchText)
                }
                return false
            }
        }

        return catches
    }

    var body: some View {
        NavigationStack {
            ZStack {
                WaveBackground()

                VStack(spacing: 0) {
                    // Quick Stats Header
                    CatchesHeader(
                        totalCatches: catchStore.getTotalCatchCount(),
                        uniqueFish: catchStore.getUniqueFishCount(),
                        totalWeight: catchStore.getTotalWeight()
                    )
                    .padding()

                    // Category Filter
                    CategoryPicker(selectedCategory: $selectedCategory)
                        .padding(.bottom)

                    // Catches List
                    if filteredCatches.isEmpty {
                        EmptyCatchesView()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filteredCatches) { record in
                                    NavigationLink(destination: CatchDetailView(record: record)) {
                                        CatchRow(
                                            record: record,
                                            fish: catchStore.getFish(by: record.fishId)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                                .onDelete(perform: deleteCatches)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search catches...")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Catches")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddCatch = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showingAddCatch) {
                AddCatchView()
            }
        }
    }

    private func deleteCatches(at offsets: IndexSet) {
        catchStore.deleteCatches(at: offsets)
    }
}

struct CatchesHeader: View {
    let totalCatches: Int
    let uniqueFish: Int
    let totalWeight: Double

    var body: some View {
        HStack(spacing: 16) {
            StatCard(
                icon: "fish.fill",
                value: "\(totalCatches)",
                label: "Catches"
            )
            StatCard(
                icon: "star.fill",
                value: "\(uniqueFish)",
                label: "Species"
            )
            StatCard(
                icon: "scalemass.fill",
                value: String(format: "%.1f kg", totalWeight),
                label: "Total"
            )
        }
    }
}

struct StatCard: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(Color(hex: "26d0ce"))

            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .glassCard()
    }
}

struct CatchDetailView: View {
    @Environment(CatchStore.self) private var catchStore
    @Environment(\.dismiss) private var dismiss

    let record: CatchRecord

    private var fish: Fish? {
        catchStore.getFish(by: record.fishId)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Photo or Icon
                if let photoData = record.photoData, let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                } else if let fish = fish {
                    ZStack {
                        fish.category.gradient

                        Image(systemName: fish.imageName)
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                }

                // Fish Name
                if let fish = fish {
                    VStack(spacing: 4) {
                        Text(fish.name)
                            .font(.title)
                            .fontWeight(.bold)

                        Text(fish.scientificName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }

                // Catch Stats
                HStack(spacing: 16) {
                    StatBox(
                        icon: "scalemass.fill",
                        value: record.formattedWeight,
                        label: "Weight"
                    )
                    StatBox(
                        icon: "ruler.fill",
                        value: record.formattedLength,
                        label: "Length"
                    )
                }
                .padding(.horizontal)

                // Details
                VStack(spacing: 16) {
                    DetailRow(icon: "calendar", title: "Date", value: record.formattedDate)
                    DetailRow(icon: "mappin.circle.fill", title: "Location", value: record.location)
                    DetailRow(icon: record.weather.icon, title: "Weather", value: record.weather.rawValue)

                    if !record.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Notes", systemImage: "note.text")
                                .font(.headline)
                            Text(record.notes)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Delete Button
                Button(role: .destructive) {
                    catchStore.deleteCatch(record)
                    dismiss()
                } label: {
                    Label("Delete Catch", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red.opacity(0.1))
                        .foregroundColor(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                Spacer(minLength: 50)
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    CatchesView()
        .environment(CatchStore())
}
