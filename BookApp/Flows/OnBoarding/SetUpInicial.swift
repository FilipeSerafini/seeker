import SwiftUI

struct SetUpInicial: View {
    @State var username = ""
    @State var name = ""
    @Binding var onboarding: Bool
    
    var body: some View {
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
                        TextField("Nome", text: $name)
                        .padding(.top)
                        .onChange(of: name) { newValue in
                            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
                            let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
                            name = String(filteredText)
                        }
                        Divider()
                        
                        TextField("username", text: $username)
                        .padding(.top)
                        .autocapitalization(.none)
                        .onChange(of: username) { newValue in
                            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-")
                            let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
                            username = String(filteredText.prefix(10))
                        }
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
        
            NavigationLink(destination: SetUpInicial2(username: $username, name: $name, onboarding: $onboarding)                .navigationBarBackButtonHidden(true), label: {
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
