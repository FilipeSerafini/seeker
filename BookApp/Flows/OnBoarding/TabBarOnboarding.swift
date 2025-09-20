import SwiftUI

struct TabBarOnboarding: View {
    @State private var currentPageIndex = 0
    @AppStorage("firstTimeHere") private var showOnboarding = true
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        TabView(selection: $currentPageIndex){
            OnBoarding1()
                .tag(0)
            OnBoarding2()
                .tag(1)
            OnBoarding3()
                .tag(2)
                .environmentObject(userManager)
        }
        .padding(.vertical)
        .ignoresSafeArea()
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                if currentPageIndex != 2 {
                    if !userManager.userAlreadyOnCK {
                        NavigationLink{
                            SetUpInicial().navigationBarBackButtonHidden(true)
                        }
                        label: {
                            Text("Pular")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                                .padding(.trailing)
                        }
                    } else {
                        Button(action: {
                            showOnboarding = false
                        } ,label: {
                            Text("Pular")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding(.top, 20)
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
}
