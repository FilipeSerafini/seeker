import SwiftUI

struct SetUpInicial2: View {
    @State private var username = ""
    @State private var name = ""
    @State private var isEditing: Bool = false
    @EnvironmentObject private var selectedGenres: SelectedGenres
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Vamos nos conhecer melhor!\nQuais são seus gêneros literários favoritos?")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .regular))
                        .padding(.bottom)
                    
                    Text("Escolha ao menos três para prosseguir.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 15))
                }
                
                VStack {
                    GenreButtonOnboarding()
                }
                .padding(.top, 50)
                
                NavigationLink(destination: TabViewApp()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(UserCRUD())
                    .environmentObject(UserManager())
                    .environmentObject(recommendedViewModel)
                    .environmentObject(selectedGenres), label: {
                        ZStack {
                            Rectangle()
                                .fill(Color("primary"))
                                .cornerRadius(30)
                                .frame(width: 100, height: 45)
                            Text("Começar")
                                .foregroundColor(.white)
                        }
                    })
                .disabled(selectedGenres.genres.count < 3)
                .opacity(selectedGenres.genres.count < 3 ? 0.6 : 1)
                .padding(.top, 60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}

struct SetUpInicial2_Previews: PreviewProvider {
    static var previews: some View {
        SetUpInicial2()
            .environmentObject(SelectedGenres())
    }
}
