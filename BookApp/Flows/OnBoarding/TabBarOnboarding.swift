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
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SetUpInicial().navigationBarBackButtonHidden(true), label: {
                        Text("Pular")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
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
        .environmentObject(SelectedGenres())
    }
}
