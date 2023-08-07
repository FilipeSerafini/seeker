import SwiftUI

struct TabBarOnboarding: View {
    var body: some View {
        NavigationStack{
            TabView {
                OnBoarding1()
                OnBoarding2()
                OnBoarding3()
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        TabBarOnboarding()
    }
}
