import SwiftUI

struct SetUpInicial2: View {
    @State private var username = ""
    @State private var name = ""
    @State private var isEditing: Bool = false
    @EnvironmentObject private var selectedGenres: SelectedGenres
    @Binding var onboarding: Bool
    
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
    }
}

//struct SetUpInicial2_Previews: PreviewProvider {
//    static var previews: some View {
//        SetUpInicial2()
////            .environmentObject(SelectedGenres())
////            .environmentObject(RecommendedViewModel())
//    }
//}
