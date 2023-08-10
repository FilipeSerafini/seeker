import SwiftUI

struct SetUpInicial: View {
    
    @State private var username = ""
    @State private var name = ""
    @State private var isEditing: Bool = false
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Como você gostaria de ser chamado?")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .regular))
            }
            .padding(.bottom, 20)
            
            VStack {
                HStack{
                    Text("Nome")
                    TextField("Nome", text: $username, onEditingChanged: { editing in isEditing = editing
                    })
                    .padding(.leading, 45)
                }
                Divider()
                    .padding(.leading, 100)
                HStack{
                    Text("Username")
                    TextField("username", text: $name, onEditingChanged: { editing in isEditing = editing
                    })
                    .padding(.leading, 12)
                }
                Divider()
            }
            .padding()
            .padding(.bottom, 80)
            
            Image("zoeChat")
                .resizable()
                .frame(width: 340, height: 240)
            
            NavigationLink(destination: SetUpInicial2().navigationBarBackButtonHidden(true), label: {
                ZStack {
                    Rectangle()
                        .fill(Color("primary"))
                        .cornerRadius(30)
                        .frame(width: 100, height: 45)
                    Text("Continuar")
                        .foregroundColor(.white)
                }
            })
            .padding(.top, 60)
            
        }
    }
}

struct SetUpInicial_Previews: PreviewProvider {
    static var previews: some View {
        SetUpInicial()
    }
}
