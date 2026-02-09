
import SwiftUI

struct CategoryPicker: View {
    @Binding var selectedCategory: FishCategory?
    var showAll: Bool = true

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                if showAll {
                    CategoryButton(
                        title: "All",
                        icon: "square.grid.2x2.fill",
                        color: .white,
                        isSelected: selectedCategory == nil
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedCategory = nil
                        }
                    }
                }

                ForEach(FishCategory.allCases) { category in
                    CategoryButton(
                        title: category.rawValue,
                        icon: category.icon,
                        color: category.color,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(isSelected ? .white : color)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Group {
                    if isSelected {
                        color
                    } else {
                        color.opacity(0.15)
                    }
                }
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct WeatherPicker: View {
    @Binding var selectedWeather: Weather

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Weather.allCases) { weather in
                    WeatherButton(
                        weather: weather,
                        isSelected: selectedWeather == weather
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedWeather = weather
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WeatherButton: View {
    let weather: Weather
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: weather.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : weather.color)
                Text(weather.rawValue)
                    .font(.caption)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(width: 70, height: 70)
            .background(
                isSelected ? weather.color : Color(.systemGray6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(weather.color, lineWidth: isSelected ? 2 : 0)
            )
        }
        .buttonStyle(.plain)
    }
}

struct RarityBadge: View {
    let rarity: FishRarity

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<rarity.stars, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .font(.system(size: 10))
            }
        }
        .foregroundColor(rarity.color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(rarity.color.opacity(0.2))
        .clipShape(Capsule())
    }
}

struct DifficultyBadge: View {
    let difficulty: Difficulty

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: difficulty.icon)
                .font(.system(size: 12))
            Text(difficulty.rawValue)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(difficulty.color)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(difficulty.color.opacity(0.15))
        .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: 20) {
        CategoryPicker(selectedCategory: .constant(nil))
        WeatherPicker(selectedWeather: .constant(.sunny))
        RarityBadge(rarity: .legendary)
        DifficultyBadge(difficulty: .medium)
    }
    .padding()
}
