
import SwiftUI

struct RecipeDetailView: View {
    @Environment(CatchStore.self) private var catchStore

    let recipe: Recipe
    @State private var completedSteps: Set<Int> = []
    @State private var showingTimer = false
    @State private var timerMinutes: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                RecipeDetailHeader(recipe: recipe)

                // Quick Info Cards
                HStack(spacing: 12) {
                    QuickInfoCard(
                        icon: "clock",
                        title: "Prep Time",
                        value: recipe.formattedPrepTime,
                        color: .blue
                    )
                    QuickInfoCard(
                        icon: "flame",
                        title: "Cook Time",
                        value: recipe.formattedCookTime,
                        color: .orange
                    )
                    QuickInfoCard(
                        icon: "person.2",
                        title: "Servings",
                        value: "\(recipe.servings)",
                        color: .green
                    )
                }
                .padding(.horizontal)

                // Timer Button
                Button {
                    timerMinutes = recipe.cookingTime
                    showingTimer = true
                } label: {
                    HStack {
                        Image(systemName: "timer")
                        Text("Start Cooking Timer")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                // Ingredients
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Ingredients", icon: "list.bullet.clipboard")

                    ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                        IngredientRow(ingredient: ingredient, index: index + 1)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Instructions
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Instructions", icon: "text.book.closed")

                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                        InstructionRow(
                            step: index + 1,
                            instruction: instruction,
                            isCompleted: completedSteps.contains(index)
                        ) {
                            withAnimation {
                                if completedSteps.contains(index) {
                                    completedSteps.remove(index)
                                } else {
                                    completedSteps.insert(index)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Progress
                if !completedSteps.isEmpty {
                    CookingProgress(
                        completed: completedSteps.count,
                        total: recipe.instructions.count
                    )
                    .padding(.horizontal)
                }

                Spacer(minLength: 50)
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            catchStore.markRecipeAsViewed(recipe)
        }
        .sheet(isPresented: $showingTimer) {
            CookingTimerView(minutes: timerMinutes)
        }
    }
}

struct RecipeDetailHeader: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 16) {
                Image(systemName: "fork.knife")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .background(.white.opacity(0.2))
                    .clipShape(Circle())

                VStack(spacing: 8) {
                    Text(recipe.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text("For \(recipe.fishName)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    DifficultyBadge(difficulty: recipe.difficulty)
                }
            }
            .padding(.vertical, 30)
        }
        .frame(height: 250)
    }
}

struct QuickInfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.headline)

            Text(title)
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

struct IngredientRow: View {
    let ingredient: String
    let index: Int
    @State private var isChecked = false

    var body: some View {
        Button {
            withAnimation {
                isChecked.toggle()
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isChecked ? .green : .secondary)
                    .font(.title3)

                Text(ingredient)
                    .strikethrough(isChecked)
                    .foregroundColor(isChecked ? .secondary : .primary)

                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

struct InstructionRow: View {
    let step: Int
    let instruction: String
    let isCompleted: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color.green : Color(hex: "26d0ce"))
                        .frame(width: 32, height: 32)

                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    } else {
                        Text("\(step)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }

                Text(instruction)
                    .font(.body)
                    .foregroundColor(isCompleted ? .secondary : .primary)
                    .strikethrough(isCompleted)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
        }
        .buttonStyle(.plain)
        .padding()
        .background(isCompleted ? Color.green.opacity(0.1) : Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct CookingProgress: View {
    let completed: Int
    let total: Int

    private var progress: Double {
        Double(completed) / Double(total)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Progress")
                    .font(.headline)
                Spacer()
                Text("\(completed)/\(total) steps")
                    .foregroundColor(.secondary)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .frame(height: 10)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green)
                        .frame(width: geometry.size.width * progress, height: 10)
                }
            }
            .frame(height: 10)

            if completed == total {
                Text("Recipe Complete! Enjoy your meal!")
                    .font(.headline)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct CookingTimerView: View {
    @Environment(\.dismiss) private var dismiss
    let minutes: Int

    @State private var timeRemaining: Int
    @State private var isRunning = false
    @State private var timer: Timer?

    init(minutes: Int) {
        self.minutes = minutes
        self._timeRemaining = State(initialValue: minutes * 60)
    }

    private var formattedTime: String {
        let mins = timeRemaining / 60
        let secs = timeRemaining % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                ZStack {
                    Circle()
                        .stroke(Color(.systemGray4), lineWidth: 12)
                        .frame(width: 250, height: 250)

                    Circle()
                        .trim(from: 0, to: CGFloat(timeRemaining) / CGFloat(minutes * 60))
                        .stroke(
                            LinearGradient(
                                colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .frame(width: 250, height: 250)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: timeRemaining)

                    VStack(spacing: 8) {
                        Text(formattedTime)
                            .font(.system(size: 48, weight: .bold, design: .monospaced))

                        Text(isRunning ? "Cooking..." : "Ready")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(spacing: 40) {
                    Button {
                        timeRemaining = minutes * 60
                        isRunning = false
                        timer?.invalidate()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title)
                            .foregroundColor(.secondary)
                            .frame(width: 60, height: 60)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }

                    Button {
                        if isRunning {
                            timer?.invalidate()
                        } else {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                } else {
                                    timer?.invalidate()
                                    isRunning = false
                                }
                            }
                        }
                        isRunning.toggle()
                    } label: {
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Cooking Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        timer?.invalidate()
                        dismiss()
                    }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: FishData.freshwaterFish[0].recipes[0])
            .environment(CatchStore())
    }
}
