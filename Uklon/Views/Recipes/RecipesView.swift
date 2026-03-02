
import SwiftUI

struct RecipesView: View {
    @Environment(CatchStore.self) private var catchStore
    @State private var selectedCategory: FishCategory? = nil
    @State private var selectedDifficulty: Difficulty? = nil
    @State private var searchText = ""
    @State private var viewMode: ViewMode = .list

    enum ViewMode {
        case list, grid
    }

    private var allRecipes: [Recipe] {
        catchStore.getAllRecipes()
    }

    private var filteredRecipes: [Recipe] {
        var recipes = allRecipes

        if let category = selectedCategory {
            recipes = catchStore.getRecipes(for: category)
        }

        if let difficulty = selectedDifficulty {
            recipes = recipes.filter { $0.difficulty == difficulty }
        }

        if !searchText.isEmpty {
            recipes = recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.fishName.localizedCaseInsensitiveContains(searchText)
            }
        }

        return recipes
    }

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150), spacing: 16)]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                OceanGradient()

                VStack(spacing: 0) {
                    // Recipe Stats
                    RecipeHeader(
                        totalRecipes: allRecipes.count,
                        viewedRecipes: catchStore.viewedRecipes.count
                    )
                    .padding()

                    // Category Filter
                    CategoryPicker(selectedCategory: $selectedCategory)
                        .padding(.bottom, 8)

                    // Difficulty Filter
                    DifficultyFilter(selectedDifficulty: $selectedDifficulty)
                        .padding(.bottom)

                    // Recipes List/Grid
                    ScrollView {
                        if filteredRecipes.isEmpty {
                            ContentUnavailableView(
                                "No Recipes Found",
                                systemImage: "fork.knife",
                                description: Text("Try adjusting your filters")
                            )
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        } else {
                            switch viewMode {
                            case .list:
                                LazyVStack(spacing: 12) {
                                    ForEach(filteredRecipes) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            RecipeCard(recipe: recipe)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal)
                            case .grid:
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(filteredRecipes) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            RecipeGridCard(recipe: recipe)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        Spacer(minLength: 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search recipes...")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            viewMode = viewMode == .list ? .grid : .list
                        }
                    } label: {
                        Image(systemName: viewMode == .list ? "square.grid.2x2" : "list.bullet")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct RecipeHeader: View {
    let totalRecipes: Int
    let viewedRecipes: Int

    private var progress: Double {
        guard totalRecipes > 0 else { return 0 }
        return Double(viewedRecipes) / Double(totalRecipes)
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Recipe Collection")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(viewedRecipes) of \(totalRecipes) recipes viewed")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()

            CircularProgress(progress: progress)
        }
        .padding()
        .glassCard()
    }
}

struct CircularProgress: View {
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.3), lineWidth: 6)
                .frame(width: 50, height: 50)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(hex: "26d0ce"),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(-90))

            Text("\(Int(progress * 100))%")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct DifficultyFilter: View {
    @Binding var selectedDifficulty: Difficulty?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                DifficultyButton(
                    title: "All",
                    color: .white,
                    isSelected: selectedDifficulty == nil
                ) {
                    withAnimation {
                        selectedDifficulty = nil
                    }
                }

                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    DifficultyButton(
                        title: difficulty.rawValue,
                        color: difficulty.color,
                        isSelected: selectedDifficulty == difficulty
                    ) {
                        withAnimation {
                            selectedDifficulty = difficulty
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct DifficultyButton: View {
    let title: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? color : color.opacity(0.15))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    RecipesView()
        .environment(CatchStore())
}
