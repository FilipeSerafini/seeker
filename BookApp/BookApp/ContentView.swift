
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
                }
                else{
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
            recommendedViewModel.fetchAll(searchedText: "Young Adult Fiction", "Romance", "Rupi Kaur", filter: .genre, .author)
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
