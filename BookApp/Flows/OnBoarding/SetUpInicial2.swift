import SwiftUI

struct SetUpInicial2: View {
    // @Binding var username: String
    @State private var isEditing: Bool = false
    @Binding var name: String
    @Binding var onboarding: Bool
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject private var selectedGenres: SelectedGenres
    @Environment(\.dynamicTypeSize) var size
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("Vamos nos conhecer melhor!\nQuais são seus gêneros literários favoritos?")
                        .multilineTextAlignment(.center)
                        .scaledFont(size: 17)
                        .padding(.bottom)
                        .accessibilityLabel("Vamos nos conhecer melhor! Quais são seus gêneros literários favoritos?")
                    
                    Text("Escolha três para prosseguir.")
                        .multilineTextAlignment(.center)
                        .scaledFont(size: 15)
                        .accessibilityLabel("Escolha três gêneros para prosseguir")
                        .accessibilityHint("Toque para selecionar seus gêneros literários favoritos")
                    
                    GenreButtonOnboarding()
                        .padding(.vertical, 70)
                    
                    Button(action: {
                        self.onboarding = false
                    } ,label: {
                        Text("Tudo pronto!")
                            .foregroundColor(.white)
                            .scaledFont(size: 17)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color("primary"))
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                            )
                            .cornerRadius(20)
                            .accessibility(hidden: selectedGenres.genres.count < 3 ? true : false)
                            .accessibilityLabel(selectedGenres.genres.count >= 3 ? "Tudo pronto! Clique para continuar. Botão habilitado." : "") //Botão de continuar desabilitado. Selecione pelo menos três generos.
                    })
                    .disabled(selectedGenres.genres.count < 3)
                    .opacity(selectedGenres.genres.count < 3 ? 0.6 : 1)
                }
                .padding()
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(size >= .xLarge ? false : true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .accessibility(hidden: true)
        )
        .background(Color("backgroundColor"))
        .onAppear {
            UserDefaults.standard.set(name, forKey: "name")
            // UserDefaults.standard.set(username, forKey: "username")
        }
        .onDisappear {
            let user: User = User(name: name, bio: "", favoriteGenres: selectedGenres.genresUser, image: "", favoriteGenresForAPI: selectedGenres.genresAPI)!
            
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
