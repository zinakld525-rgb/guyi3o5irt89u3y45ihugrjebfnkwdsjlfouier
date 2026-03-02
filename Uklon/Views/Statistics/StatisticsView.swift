
import SwiftUI
import Charts

struct StatisticsView: View {
    @Environment(CatchStore.self) private var catchStore

    var body: some View {
        NavigationStack {
            ZStack {
                OceanGradient()

                ScrollView {
                    VStack(spacing: 20) {
                        // Overview Stats
                        OverviewStats(catchStore: catchStore)
                            .padding(.horizontal)

                        // Catches by Category Chart
                        CatchesByCategoryChart(catchStore: catchStore)
                            .padding(.horizontal)

                        // Catches by Month Chart
                        CatchesByMonthChart(catchStore: catchStore)
                            .padding(.horizontal)

                        // Weather Distribution
                        WeatherDistributionChart(catchStore: catchStore)
                            .padding(.horizontal)

                        // Personal Records
                        PersonalRecords(catchStore: catchStore)
                            .padding(.horizontal)

                        // Recent Activity
                        RecentActivity(catchStore: catchStore)
                            .padding(.horizontal)

                        Spacer(minLength: 20)
                    }
                    .padding(.top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Statistics")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct OverviewStats: View {
    let catchStore: CatchStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Overview")
                .font(.headline)
                .foregroundColor(.white)

            HStack(spacing: 12) {
                OverviewCard(
                    icon: "fish.fill",
                    value: "\(catchStore.getTotalCatchCount())",
                    label: "Total Catches",
                    color: Color(hex: "26d0ce")
                )
                OverviewCard(
                    icon: "star.fill",
                    value: "\(catchStore.getUniqueFishCount())",
                    label: "Species",
                    color: .yellow
                )
            }

            HStack(spacing: 12) {
                OverviewCard(
                    icon: "scalemass.fill",
                    value: String(format: "%.1f kg", catchStore.getTotalWeight()),
                    label: "Total Weight",
                    color: .green
                )
                OverviewCard(
                    icon: "percent",
                    value: "\(Int(Double(catchStore.getUniqueFishCount()) / 100.0 * 100))%",
                    label: "Completion",
                    color: .orange
                )
            }
        }
    }
}

struct OverviewCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.2))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct CatchesByCategoryChart: View {
    let catchStore: CatchStore

    private var categoryData: [(category: FishCategory, count: Int)] {
        let data = catchStore.getCatchesByCategory()
        return FishCategory.allCases.map { ($0, data[$0] ?? 0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Catches by Category")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 0) {
                if categoryData.contains(where: { $0.count > 0 }) {
                    Chart(categoryData, id: \.category) { item in
                        BarMark(
                            x: .value("Count", item.count),
                            y: .value("Category", item.category.rawValue)
                        )
                        .foregroundStyle(item.category.color)
                        .cornerRadius(6)
                    }
                    .frame(height: 200)
                    .padding()
                } else {
                    EmptyChartView(message: "Catch some fish to see stats!")
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct CatchesByMonthChart: View {
    let catchStore: CatchStore

    private var monthlyData: [(month: String, count: Int)] {
        catchStore.getCatchesByMonth()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Catches by Month")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 0) {
                if monthlyData.contains(where: { $0.count > 0 }) {
                    Chart(monthlyData, id: \.month) { item in
                        BarMark(
                            x: .value("Month", item.month),
                            y: .value("Count", item.count)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(hex: "26d0ce"), Color(hex: "1a2980")],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .cornerRadius(6)
                    }
                    .frame(height: 200)
                    .padding()
                } else {
                    EmptyChartView(message: "Start logging catches to track monthly progress!")
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct WeatherDistributionChart: View {
    let catchStore: CatchStore

    private var weatherData: [(weather: Weather, count: Int)] {
        let data = catchStore.getCatchesByWeather()
        return Weather.allCases.map { ($0, data[$0] ?? 0) }.filter { $0.count > 0 }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Weather Conditions")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 0) {
                if !weatherData.isEmpty {
                    Chart(weatherData, id: \.weather) { item in
                        SectorMark(
                            angle: .value("Count", item.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 2
                        )
                        .foregroundStyle(item.weather.color)
                        .annotation(position: .overlay) {
                            VStack {
                                Image(systemName: item.weather.icon)
                                    .font(.caption)
                                Text("\(item.count)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                        }
                    }
                    .frame(height: 200)
                    .padding()

                    // Legend
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                        ForEach(weatherData, id: \.weather) { item in
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(item.weather.color)
                                    .frame(width: 10, height: 10)
                                Text(item.weather.rawValue)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                } else {
                    EmptyChartView(message: "Weather data will appear after your first catch!")
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct PersonalRecords: View {
    let catchStore: CatchStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Personal Records")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 12) {
                if let biggest = catchStore.getBiggestCatch(),
                   let fish = catchStore.getFish(by: biggest.fishId) {
                    RecordCard(
                        icon: "scalemass.fill",
                        title: "Heaviest Catch",
                        fish: fish.name,
                        value: biggest.formattedWeight,
                        color: .orange
                    )
                }

                if let longest = catchStore.getLongestCatch(),
                   let fish = catchStore.getFish(by: longest.fishId) {
                    RecordCard(
                        icon: "ruler.fill",
                        title: "Longest Catch",
                        fish: fish.name,
                        value: longest.formattedLength,
                        color: .blue
                    )
                }

                if catchStore.getBiggestCatch() == nil {
                    EmptyRecordCard()
                }
            }
        }
    }
}

struct RecordCard: View {
    let icon: String
    let title: String
    let fish: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(fish)
                    .font(.headline)
            }

            Spacer()

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct EmptyRecordCard: View {
    var body: some View {
        HStack {
            Image(systemName: "trophy")
                .font(.title)
                .foregroundColor(.secondary)
            Text("Start fishing to set records!")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct RecentActivity: View {
    let catchStore: CatchStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Activity")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 8) {
                let recentCatches = catchStore.getRecentCatches(limit: 5)

                if recentCatches.isEmpty {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.secondary)
                        Text("No recent activity")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    ForEach(recentCatches) { record in
                        if let fish = catchStore.getFish(by: record.fishId) {
                            RecentActivityRow(record: record, fish: fish)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct RecentActivityRow: View {
    let record: CatchRecord
    let fish: Fish

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                fish.category.gradient
                Image(systemName: fish.imageName)
                    .foregroundColor(.white)
            }
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(fish.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(record.location)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(record.formattedWeight)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(record.shortDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct EmptyChartView: View {
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "chart.bar.xaxis")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding()
    }
}

#Preview {
    StatisticsView()
        .environment(CatchStore())
}
