import SwiftUI

struct TabViewApp: View {
    
    @State private var selectedTab = 0
    @StateObject var searchViewModel = SearchViewModel()
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes =
        [.font: UIFont(descriptor:
                        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(.serif)!, size: 34)]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            LibraryView()
                .tabItem {
                    selectedTab == 0 ? Image("libraryIconSelected") : Image(systemName: "books.vertical")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    selectedTab == 1 ? Image("searchIconSelected") : Image(systemName: "magnifyingglass")
                }
                .tag(1)
            
            OracleView()
                .tabItem {
                    selectedTab == 2 ? Image("oracleIconSelected") : Image("oracleIcon")
                }
                .tag(2)
            
            ChallengesView()
                .tabItem {
                    selectedTab == 3 ? Image("challengeIconSelected") : Image(systemName: "rosette")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    selectedTab == 4 ? Image("perfilIconSelected") : Image(systemName: "person")
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
