import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var catchStore = CatchStore()

    init() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        navAppearance.backgroundColor = UIColor.clear
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().tintColor = .white

        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 0.95)

        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        let selectedColor = UIColor(red: 0.15, green: 0.82, blue: 0.81, alpha: 1.0)
        tabAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            CatchesView()
                .environment(catchStore)
                .tabItem {
                    Label("My Catches", systemImage: "fish.fill")
                }
                .tag(0)

            FishCollectionView()
                .environment(catchStore)
                .tabItem {
                    Label("Collection", systemImage: "books.vertical.fill")
                }
                .tag(1)

            StatisticsView()
                .environment(catchStore)
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.fill")
                }
                .tag(2)

            RecipesView()
                .environment(catchStore)
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
                .tag(3)

            AchievementsView()
                .environment(catchStore)
                .tabItem {
                    Label("Achievements", systemImage: "trophy.fill")
                }
                .tag(4)
        }
        .tint(Color(hex: "26d0ce"))
    }
}

#Preview {
    MainTabView()
}
