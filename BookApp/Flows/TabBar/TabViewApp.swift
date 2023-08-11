import SwiftUI

extension UIImage {
    func resized(with size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

struct TabViewApp: View {
    @State private var selectedTab = 0
    @StateObject var searchViewModel: SearchViewModel = SearchViewModel()
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
    init() {
        // UITabBar configuration
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // UINavigationBar configuration
        if let image = UIImage(named: "chevronBackward"){
            let imageSize = CGSize(width: 13, height: 22)
            let resizedImage = image.resized(with: imageSize)
            
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.setBackIndicatorImage(resizedImage, transitionMaskImage: resizedImage)
            let backButtonAppearance = UIBarButtonItemAppearance(style: .done)
            backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
            backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]
            backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            navigationBarAppearance.backButtonAppearance = backButtonAppearance
            navigationBarAppearance.largeTitleTextAttributes = [.font: UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(.serif)!, size: 34)]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        }
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            LibraryView()
                .tabItem {
                    selectedTab == 0 ? Image("booksColors") : Image("books")
                    Text("Estante")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    selectedTab == 1 ? Image("magnifyingGlassColors") : Image("magnifyingGlass")
                    Text("Buscar")
                }
                .tag(1)
            
            OracleView()
                .tabItem {
                    selectedTab == 2 ? Image("zoeColors") : Image("zoe")
                    Text("Oráculo")
                }
                .tag(2)
            
            //            ChallengesView()
            //                .tabItem {
            //                    selectedTab == 3 ? Image("badgeColors") : Image("badge")
            //                }
            //                .tag(3)
            
            ProfileView()
                .tabItem {
                    selectedTab == 4 ? Image("profileColors") : Image("profile")
                    Text("Perfil")
                }
                .tag(4)
        }
        .tint(Color("primary"))
        .environmentObject(searchViewModel)
        .onAppear {
            let firstTime: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
            if firstTime {
                UserDefaults.standard.set(false, forKey: "firstTimeHere")
                UserDefaults.standard.set(selectedGenres.genres.map({ $0.toApi }), forKey: "genresAPI")
                UserDefaults.standard.set(selectedGenres.genres.map({ $0.toUser }), forKey: "genresUser")
                
                selectedGenres.genresAPI = selectedGenres.genres.map({ $0.toApi })
                selectedGenres.genresUser = selectedGenres.genres.map({ $0.toUser })
                
                recommendedViewModel.fetchAll(searchedText: selectedGenres.genresAPI[0], selectedGenres.genresAPI[1], selectedGenres.genresAPI[2], filter: .genre)
            }
        }
    }
}

//struct TabViewApp_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViewApp()
//            .environmentObject(SearchViewModel())
//            .environmentObject(RecommendedViewModel())
//            .environmentObject(SelectedGenres())
//    }
//}
