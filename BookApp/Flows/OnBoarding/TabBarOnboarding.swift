import SwiftUI

struct TabBarOnboarding: View {
    
    @Binding var onboarding: Bool
    var body: some View {
        NavigationStack{
            TabView {
                OnBoarding1()
                OnBoarding2()
                OnBoarding3(onboarding: $onboarding)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SetUpInicial(onboarding: $onboarding).navigationBarBackButtonHidden(true), label: {
                        Text("Pular")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.trailing)
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
        }
        .navigationBarBackButtonHidden(true)
    }
}
