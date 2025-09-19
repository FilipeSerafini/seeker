
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var auth: AuthService
    
    @State var onboarding: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State private var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State private var isActive = false
    
    @StateObject private var selectedGenres = SelectedGenres()
    @StateObject private var recommendedViewModel = RecommendedViewModel()
    @StateObject private var userCrud = UserCRUD()
    @StateObject private var userManager = UserManager()
    
    var body: some View {
        ZStack {
            if self.isActive {
                switch auth.phase {
                case .unknown:
                    Preview()
                case .signedOut:
                    NavigationStack {
                        AuthView()
                    }
                case .signedIn(let authDataResultModel):
                    if onboarding {
                        TabBarOnboarding(onboarding: $onboarding)
                    } else {
                        TabViewApp()
                    }
                }
            } else {
                Preview()
            }
        }
        .environmentObject(userCrud)
        .environmentObject(userManager)
        .environmentObject(recommendedViewModel)
        .environmentObject(selectedGenres)
        .onAppear {
            if !firstTimeHere {
                let genresAPI = UserDefaults.standard.object(forKey: "genresAPI") as! [String]
                selectedGenres.genresAPI = genresAPI
                
                let genresUser = UserDefaults.standard.object(forKey: "genresUser") as! [String]
                selectedGenres.genresUser = genresUser
                
                recommendedViewModel.fetchAll(searchedText: selectedGenres.genresAPI[0], selectedGenres.genresAPI[1], selectedGenres.genresAPI[2], filter: .genre)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
