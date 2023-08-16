import SwiftUI

struct SetUpInicial2: View {
    @Binding var username: String
    @Binding var name: String
    @State private var isEditing: Bool = false
    @EnvironmentObject private var selectedGenres: SelectedGenres
    @Binding var onboarding: Bool
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack{
            VStack{
                Text("Vamos nos conhecer melhor!\nQuais são seus gêneros literários favoritos?")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.bottom)
                
                Text("Escolha três para prosseguir.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 15))
            }
            
            VStack {
                GenreButtonOnboarding()
            }
            .padding(.top, 100)
            .padding(.bottom, 50)
            
            Button(action: {
                self.onboarding = false
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(Color("primary"))
                        .cornerRadius(30)
                        .frame(width: 125, height: 39)
                    Text("Tudo pronto!")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
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
        .onAppear {
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(username, forKey: "username")
        }
        .onDisappear {
            let user: User = User(name: name, username: username, bio: "", favoriteGenres: selectedGenres.genresUser, favoriteGenresForAPI: selectedGenres.genresAPI) ?? User(name: "NAO CRIOU", username: "aa", bio: "aa", favoriteGenres: [], favoriteGenresForAPI: [])!
            
            CloudKitUtility.add(item: user) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            userManager.createFolder(folderName: "Lendo agora")
            userManager.createFolder(folderName: "Livros que quero ler")
            userManager.createFolder(folderName: "Leituras realizadas")
        }
    }
}

//struct SetUpInicial2_Previews: PreviewProvider {
//    static var previews: some View {
//        SetUpInicial2()
////            .environmentObject(SelectedGenres())
////            .environmentObject(RecommendedViewModel())
//    }
//}
