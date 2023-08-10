import SwiftUI

struct TabBarOnboarding: View {
    
    @EnvironmentObject private var selectedGenres: SelectedGenres

    var body: some View {
        NavigationStack{
            TabView {
                OnBoarding1()
                OnBoarding2()
                OnBoarding3()
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .environmentObject(selectedGenres)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        TabBarOnboarding()
    }
}
