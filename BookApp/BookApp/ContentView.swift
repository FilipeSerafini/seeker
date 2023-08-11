
import SwiftUI

struct ContentView: View {
    
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State private var isActive = false
    @StateObject private var selectedGenres = SelectedGenres()
    @StateObject private var recommendedViewModel = RecommendedViewModel()
    
    var body: some View {
        ZStack {
            if self.isActive {
                if firstTimeHere {
                    TabBarOnboarding()
                        .environmentObject(selectedGenres)
                        .environmentObject(recommendedViewModel)
                } else {
                    TabViewApp()
                        .environmentObject(UserCRUD())
                        .environmentObject(UserManager())
                        .environmentObject(recommendedViewModel)
                        .environmentObject(selectedGenres)
                }
            } else {
                Preview()
            }
        }
        .onAppear {
            
            if !firstTimeHere {
                print("carregando na content")
                
                let savedGenres = UserDefaults.standard.object(forKey: "savedGenres") as! [String]
                selectedGenres.genres = savedGenres
                
                recommendedViewModel.fetchAll(searchedText: selectedGenres.genres[0], selectedGenres.genres[1], selectedGenres.genres[2], filter: .genre)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
