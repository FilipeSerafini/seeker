import SwiftUI

struct SetUpInicial: View {
    
    @State private var username = ""
    @State private var name = ""
    @State private var isEditing: Bool = false
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("Como você gostaria de ser chamado?")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17, weight: .regular))
                        .padding([.top, .bottom])
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Nome")
                                .padding([.top, .bottom])
                            Text("Username")
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                        }
                        .foregroundColor(.gray)
                        
                        VStack{
                            TextField("Nome", text: $name, onEditingChanged: { editing in isEditing = editing
                            })
                            .padding(.top)
                            Divider()
                            
                            TextField("username", text: $username, onEditingChanged: { editing in isEditing = editing
                            })
                            .padding(.top)
                            Divider()
                        }
                        .padding([.leading, .trailing])
                    }
                    .padding()
                    .padding(.bottom, 60)
                    
                    Image("zoeChat")
                        .resizable()
                        .frame(width: 400, height: 280)
                        .padding(.bottom, 60)
                }
                .font(.system(size: 17))
                
                NavigationLink(destination: SetUpInicial2().navigationBarBackButtonHidden(true), label: {
                    ZStack {
                        Rectangle()
                            .fill(Color("primary"))
                            .cornerRadius(30)
                            .frame(width: 125, height: 39)
                        Text("Continuar")
                            .foregroundColor(.white)
                    }
                })
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

struct SetUpInicial_Previews: PreviewProvider {
    static var previews: some View {
        SetUpInicial()
    }
}
