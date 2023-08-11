
import SwiftUI

struct ContentView: View {
    
    @State private var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State private var isActive = false
    @StateObject private var selectedGenres = SelectedGenres()
    @StateObject private var recommendedViewModel = RecommendedViewModel()
    @StateObject private var userCrud = UserCRUD()
    @StateObject private var userManager = UserManager()
    @State var onboarding: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    
    var body: some View {
        ZStack {
            if self.isActive {
                if onboarding {
                    TabBarOnboarding(onboarding: $onboarding)
                } else {
                    TabViewApp()
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(UserCRUD())
//            .environmentObject(UserManager())
//    }
//}
