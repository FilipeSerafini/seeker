import SwiftUI

struct TabBarOnboarding: View {
    @State private var currentPageIndex = 0
    @Binding var onboarding: Bool
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationStack{
            TabView(selection: $currentPageIndex){
                OnBoarding1()
                    .tag(0)
                OnBoarding2()
                    .tag(1)
                OnBoarding3(onboarding: $onboarding)
                    .tag(2)
                    .environmentObject(userManager)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    if currentPageIndex != 2 {
                        if userManager.userAlreadyOnCK == false {
                            NavigationLink(destination: SetUpInicial(onboarding: $onboarding).navigationBarBackButtonHidden(true), label: {
                                Text("Pular")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 50)
                                    .padding(.trailing)
                            })
                        } else {
                            NavigationLink(destination: TabViewApp().navigationBarBackButtonHidden(true), label: {
                                Text("Pular")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 50)
                                    .padding(.trailing)
                            })
                        }
                    } else {
                        Text("")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .navigationBarBackButtonHidden(true)
    }
}
