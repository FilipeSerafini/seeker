
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var auth: AuthService

    @AppStorage("firstTimeHere") private var showOnboarding = true
    @State private var isActive = false
    
    @StateObject private var selectedGenres = SelectedGenres()
    @StateObject private var recommendedViewModel = RecommendedViewModel()
    @StateObject private var userCrud = UserCRUD()
    @StateObject private var userManager = UserManager()
    
    private var isSignedOut: Bool {
        if case .signedOut = auth.phase { return true }
        return false
    }
    
    var body: some View {
        ZStack {
            if self.isActive {
                
                Group {
                    switch auth.phase {
                    case .unknown:
                        Preview()
                    case .signedOut:
                        Preview()
                    case .signedIn:
                        if showOnboarding {
                            TabBarOnboarding()
                        } else {
                            TabViewApp()
                        }
                    }
                }
//                
//                NavigationStack {
//                    
//                }
//                .id(showOnboarding ? "onboarding" : "main")
            } else {
                Preview()
            }
        }
        .environmentObject(userCrud)
        .environmentObject(userManager)
        .environmentObject(recommendedViewModel)
        .environmentObject(selectedGenres)
        .fullScreenCover(
            isPresented: Binding(
                get: { isSignedOut },
                set: { _ in } // empty setter, closing of fullScreenCover is controled bby auth.phase
            )
        ) {
            NavigationStack {
                AuthView()
            }
        }
//        .fullScreenCover(
//            isPresented: Binding(
//                get: { if case .signedIn = auth.phase { return showOnboarding } else { return false } },
//                set: { presented in
//                    // se o usuário fechar com gesto, marque como concluído
//                    if !presented { showOnboarding = false }
//                }
//            )
//        ) {
//            // importante: sem NavigationStack aninhado aqui dentro
//            TabBarOnboarding()
//                // logs de diagnóstico temporários
//                .onAppear { print("ONBOARDING presented (firstTimeHere: \(showOnboarding))") }
//        }
        .onAppear {
//            if !firstTimeHere {
//                let genresAPI = UserDefaults.standard.object(forKey: "genresAPI") as! [String]
//                selectedGenres.genresAPI = genresAPI
//                
//                let genresUser = UserDefaults.standard.object(forKey: "genresUser") as! [String]
//                selectedGenres.genresUser = genresUser
//                
//                recommendedViewModel.fetchAll(searchedText: selectedGenres.genresAPI[0], selectedGenres.genresAPI[1], selectedGenres.genresAPI[2], filter: .genre)
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .onChange(of: showOnboarding) { new in
            print("DEBUG firstTimeHere ->", new)
        }
    }
}
