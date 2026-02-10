
import SwiftUI
import PhotosUI

struct AddCatchView: View {
    @Environment(CatchStore.self) private var catchStore
    @Environment(\.dismiss) private var dismiss

    var preselectedFish: Fish? = nil

    @State private var selectedFish: Fish?
    @State private var selectedCategory: FishCategory? = nil
    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var location: String = ""
    @State private var date = Date()
    @State private var weather: Weather = .sunny
    @State private var notes: String = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var photoData: Data?

    @State private var showingFishPicker = false
    @State private var searchText = ""

    private var isFormValid: Bool {
        selectedFish != nil &&
        !weight.isEmpty &&
        Double(weight) != nil &&
        !length.isEmpty &&
        Double(length) != nil &&
        !location.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                // Fish Selection
                Section {
                    Button {
                        showingFishPicker = true
                    } label: {
                        HStack {
                            if let fish = selectedFish {
                                ZStack {
                                    fish.category.gradient
                                    Image(systemName: fish.imageName)
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading) {
                                    Text(fish.name)
                                        .foregroundColor(.primary)
                                    Text(fish.category.rawValue)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            } else {
                                Image(systemName: "fish.fill")
                                    .foregroundColor(.secondary)
                                    .frame(width: 40, height: 40)
                                Text("Select Fish")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                } header: {
                    Text("Fish")
                }

                // Measurements
                Section {
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("0.0", text: $weight)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("kg")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Length")
                        Spacer()
                        TextField("0.0", text: $length)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("cm")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Measurements")
                }

                // Location & Date
                Section {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        TextField("Location", text: $location)
                    }

                    DatePicker("Date & Time", selection: $date)
                } header: {
                    Text("Location & Time")
                }

                // Weather
                Section {
                    WeatherPicker(selectedWeather: $weather)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                } header: {
                    Text("Weather")
                }

                // Photo
                Section {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        HStack {
                            Image(systemName: "camera.fill")
                                .foregroundColor(Color(hex: "26d0ce"))
                            Text(photoData == nil ? "Add Photo" : "Change Photo")
                        }
                    }
                    .onChange(of: selectedPhoto) { _, newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                photoData = data
                            }
                        }
                    }

                    if let photoData = photoData, let uiImage = UIImage(data: photoData) {
                        HStack {
                            Spacer()
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Spacer()
                        }

                        Button("Remove Photo", role: .destructive) {
                            self.photoData = nil
                            self.selectedPhoto = nil
                        }
                    }
                } header: {
                    Text("Photo")
                }

                // Notes
                Section {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                } header: {
                    Text("Notes")
                }
            }
            .navigationTitle("Log Catch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveCatch()
                    }
                    .fontWeight(.semibold)
                    .disabled(!isFormValid)
                }
            }
            .sheet(isPresented: $showingFishPicker) {
                FishPickerView(
                    selectedFish: $selectedFish,
                    selectedCategory: $selectedCategory
                )
            }
            .onAppear {
                if let fish = preselectedFish {
                    selectedFish = fish
                    selectedCategory = fish.category
                }
            }
        }
    }

    private func saveCatch() {
        guard let fish = selectedFish,
              let weightValue = Double(weight),
              let lengthValue = Double(length) else { return }

        let record = CatchRecord(
            fishId: fish.id,
            date: date,
            location: location,
            weight: weightValue,
            length: lengthValue,
            photoData: photoData,
            notes: notes,
            weather: weather
        )

        catchStore.addCatch(record)
        dismiss()
    }
}

struct FishPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedFish: Fish?
    @Binding var selectedCategory: FishCategory?

    @State private var searchText = ""

    private var filteredFish: [Fish] {
        var fish = FishData.allFish

        if let category = selectedCategory {
            fish = fish.filter { $0.category == category }
        }

        if !searchText.isEmpty {
            fish = fish.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }

        return fish
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CategoryPicker(selectedCategory: $selectedCategory)
                    .padding(.vertical)

                List(filteredFish) { fish in
                    Button {
                        selectedFish = fish
                        dismiss()
                    } label: {
                        HStack {
                            ZStack {
                                fish.category.gradient
                                Image(systemName: fish.imageName)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading) {
                                Text(fish.name)
                                    .foregroundColor(.primary)
                                Text(fish.scientificName)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .italic()
                            }

                            Spacer()

                            RarityBadge(rarity: fish.rarity)

                            if selectedFish?.id == fish.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Select Fish")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search fish...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddCatchView()
        .environment(CatchStore())
}
