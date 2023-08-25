import SwiftUI

struct SetUpInicial2: View {
   // @Binding var username: String
    @State private var isEditing: Bool = false
    @Binding var name: String
    @Binding var onboarding: Bool
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
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
            .padding(.top, 75)
            .padding(.bottom, 75)
            
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
           // .padding(.top, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .background(Color("backgroundColor"))
        .onAppear {
            UserDefaults.standard.set(name, forKey: "name")
           // UserDefaults.standard.set(username, forKey: "username")
        }
        .onDisappear {
            let user: User = User(name: name, bio: "", favoriteGenres: selectedGenres.genresUser, image: "", favoriteGenresForAPI: selectedGenres.genresAPI) ?? User(name: "NAO CRIOU", bio: "aa", favoriteGenres: [], image: "", favoriteGenresForAPI: [])!
            
            CloudKitUtility.add(item: user) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            userManager.createFolder(folderName: "Lendo agora", description: "NaoApagar")
            userManager.createFolder(folderName: "Livros que quero ler", description: "NaoApagar")
            userManager.createFolder(folderName: "Leituras realizadas", description: "NaoApagar")
        }
    }
}
