
import SwiftUI

struct AchievementCard: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        achievement.isUnlocked
                            ? LinearGradient(
                                colors: [.yellow, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            : LinearGradient(
                                colors: [Color(.systemGray4), Color(.systemGray5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                    )
                    .frame(width: 70, height: 70)

                Image(systemName: achievement.iconName)
                    .font(.title)
                    .foregroundColor(achievement.isUnlocked ? .white : .gray)

                if achievement.isUnlocked {
                    Circle()
                        .stroke(.yellow.opacity(0.5), lineWidth: 4)
                        .frame(width: 80, height: 80)
                }
            }

            // Title
            Text(achievement.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(achievement.isUnlocked ? .primary : .secondary)

            // Progress or Checkmark
            if achievement.isUnlocked {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                // Progress Bar
                VStack(spacing: 4) {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemGray5))
                                .frame(height: 6)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "26d0ce"))
                                .frame(
                                    width: geometry.size.width * achievement.progressPercentage,
                                    height: 6
                                )
                        }
                    }
                    .frame(height: 6)

                    Text(achievement.progressText)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(width: 130)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: achievement.isUnlocked ? .yellow.opacity(0.3) : .black.opacity(0.05),
            radius: achievement.isUnlocked ? 10 : 5,
            x: 0,
            y: achievement.isUnlocked ? 0 : 2
        )
    }
}

struct AchievementListCard: View {
    let achievement: Achievement

    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        achievement.isUnlocked
                            ? LinearGradient(
                                colors: [.yellow, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            : LinearGradient(
                                colors: [Color(.systemGray4), Color(.systemGray5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                    )
                    .frame(width: 60, height: 60)

                Image(systemName: achievement.iconName)
                    .font(.title2)
                    .foregroundColor(achievement.isUnlocked ? .white : .gray)
            }

            // Info
            VStack(alignment: .leading, spacing: 6) {
                Text(achievement.name)
                    .font(.headline)
                    .foregroundColor(achievement.isUnlocked ? .primary : .secondary)

                Text(achievement.description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                if !achievement.isUnlocked {
                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemGray5))
                                .frame(height: 6)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "26d0ce"))
                                .frame(
                                    width: geometry.size.width * achievement.progressPercentage,
                                    height: 6
                                )
                        }
                    }
                    .frame(height: 6)
                }
            }

            Spacer()

            // Status
            if achievement.isUnlocked {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            } else {
                Text(achievement.progressText)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(
            color: achievement.isUnlocked ? .yellow.opacity(0.2) : .black.opacity(0.05),
            radius: 5,
            x: 0,
            y: 2
        )
    }
}

struct AchievementUnlockedView: View {
    let achievement: Achievement
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 20) {
            // Animated Icon
            ZStack {
                // Background glow
                Circle()
                    .fill(.yellow.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .opacity(isAnimating ? 0.5 : 1.0)

                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)

                Image(systemName: achievement.iconName)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)

                // Stars
                ForEach(0..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .offset(
                            x: cos(Double(index) * .pi / 3) * (isAnimating ? 80 : 60),
                            y: sin(Double(index) * .pi / 3) * (isAnimating ? 80 : 60)
                        )
                        .opacity(isAnimating ? 1 : 0)
                }
            }

            VStack(spacing: 8) {
                Text("Achievement Unlocked!")
                    .font(.caption)
                    .foregroundColor(.yellow)
                    .textCase(.uppercase)
                    .tracking(2)

                Text(achievement.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(40)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack {
            AchievementCard(achievement: Achievement.allAchievements[0])
            AchievementCard(
                achievement: Achievement(
                    id: "test",
                    name: "First Catch",
                    description: "Catch your first fish",
                    iconName: "fish.fill",
                    requirement: 1,
                    type: .totalCatches,
                    isUnlocked: true,
                    progress: 1
                )
            )
        }

        AchievementListCard(achievement: Achievement.allAchievements[0])
            .padding(.horizontal)

        AchievementUnlockedView(
            achievement: Achievement(
                id: "test",
                name: "Master Collector",
                description: "Catch all 100 species",
                iconName: "crown.fill",
                requirement: 100,
                type: .uniqueFish,
                isUnlocked: true,
                progress: 100
            )
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
