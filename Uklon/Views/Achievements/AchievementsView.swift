
import SwiftUI

struct AchievementsView: View {
    @Environment(CatchStore.self) private var catchStore
    @State private var viewMode: ViewMode = .grid
    @State private var showUnlockedOnly = false

    enum ViewMode {
        case grid, list
    }

    private var filteredAchievements: [Achievement] {
        if showUnlockedOnly {
            return catchStore.achievements.filter { $0.isUnlocked }
        }
        return catchStore.achievements
    }

    private var unlockedCount: Int {
        catchStore.getUnlockedAchievements().count
    }

    private var totalCount: Int {
        catchStore.achievements.count
    }

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 130), spacing: 16)]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                OceanGradient()

                VStack(spacing: 0) {
                    // Header Stats
                    AchievementsHeader(
                        unlocked: unlockedCount,
                        total: totalCount
                    )
                    .padding()

                    // Content
                    ScrollView {
                        if filteredAchievements.isEmpty {
                            ContentUnavailableView(
                                "No Achievements Yet",
                                systemImage: "trophy",
                                description: Text("Start fishing to unlock achievements!")
                            )
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        } else {
                            switch viewMode {
                            case .grid:
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(filteredAchievements) { achievement in
                                        AchievementCard(achievement: achievement)
                                    }
                                }
                                .padding(.horizontal)
                            case .list:
                                LazyVStack(spacing: 12) {
                                    ForEach(filteredAchievements) { achievement in
                                        AchievementListCard(achievement: achievement)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            showUnlockedOnly.toggle()
                        }
                    } label: {
                        Image(systemName: showUnlockedOnly ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(showUnlockedOnly ? .green : .white)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Achievements")
                        .font(.headline)
                        .foregroundColor(.white)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            viewMode = viewMode == .grid ? .list : .grid
                        }
                    } label: {
                        Image(systemName: viewMode == .grid ? "list.bullet" : "square.grid.2x2")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct AchievementsHeader: View {
    let unlocked: Int
    let total: Int

    private var progress: Double {
        guard total > 0 else { return 0 }
        return Double(unlocked) / Double(total)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your Achievements")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(unlocked) of \(total) unlocked")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }

                Spacer()

                // Trophy with count
                ZStack {
                    Circle()
                        .fill(.yellow.opacity(0.2))
                        .frame(width: 60, height: 60)

                    Image(systemName: "trophy.fill")
                        .font(.title)
                        .foregroundColor(.yellow)

                    Text("\(unlocked)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(.green)
                        .clipShape(Circle())
                        .offset(x: 18, y: 18)
                }
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
                                colors: [.yellow, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 10)
                }
            }
            .frame(height: 10)

            // Quick Stats
            HStack(spacing: 20) {
                AchievementQuickStat(
                    icon: "fish.fill",
                    label: "Catches",
                    count: countAchievements(of: .totalCatches)
                )
                AchievementQuickStat(
                    icon: "star.fill",
                    label: "Collection",
                    count: countAchievements(of: .uniqueFish)
                )
                AchievementQuickStat(
                    icon: "crown.fill",
                    label: "Category",
                    count: countAchievements(of: .categoryComplete)
                )
            }
        }
        .padding()
        .glassCard()
    }

    private func countAchievements(of type: AchievementType) -> Int {
        Achievement.allAchievements.filter { $0.type == type }.count
    }
}

struct AchievementQuickStat: View {
    let icon: String
    let label: String
    let count: Int

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.yellow)
            Text("\(count)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(label)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AchievementsView()
        .environment(CatchStore())
}
