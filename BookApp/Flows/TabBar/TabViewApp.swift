import SwiftUI

struct TabViewApp: View {
    
    @State private var selectedTab = 0
    @StateObject var searchViewModel = SearchViewModel()
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        let navigationBarAppearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance(style: .done)
        backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.backButtonAppearance = backButtonAppearance
        navigationBarAppearance.largeTitleTextAttributes = [.font: UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(.serif)!, size: 34)]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            LibraryView()
                .tabItem {
                    selectedTab == 0 ? Image("booksColors") : Image("booksLight")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    selectedTab == 1 ? Image("magnifyingGlassColors") : Image("magnifyingGlassLight")
                }
                .tag(1)
            
            OracleView()
                .tabItem {
                    selectedTab == 2 ? Image("zoeColors") : Image("zoeLight")
                }
                .tag(2)
            
            ChallengesView()
                .tabItem {
                    selectedTab == 3 ? Image("badgeColors") : Image("badgeLight")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    selectedTab == 4 ? Image("profileColors") : Image("profileLight")
                }
                .tag(4)
        }
        .tint(Color(red: 0.514, green: 0.574, blue: 0.856))
        .environmentObject(searchViewModel)
        .environmentObject(recommendedViewModel)

    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
