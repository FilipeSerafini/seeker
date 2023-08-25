import SwiftUI

struct SetUpInicial: View {
    @State var name = ""
    @Binding var onboarding: Bool
    // @State var username = ""
    // @State var usernameAvailable: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Como você gostaria de ser chamado?")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .regular))
                    .padding([.top, .bottom])
                    .padding(.top, 50)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Nome")
                            .padding([.top, .bottom])
//                        Text("Username")
//                            .padding(.top, 10)
//                            .padding(.bottom, 10)
                    }
                    .foregroundColor(.gray)
                    
                    VStack {
                        TextField("Nome", text: $name)
                        .padding(.top)
                        .onChange(of: name) { newValue in
                                let forbiddenCharacterSet = CharacterSet(charactersIn: "&$#@!%*()+=[]{}|;:'\",<>/?-_€£0123456789")
                                let filteredText = newValue.filter { !forbiddenCharacterSet.contains(UnicodeScalar(String($0))!)}
                                name = String(filteredText.prefix(25))
                            }
                        Divider()
                        
//                        TextField("Username", text: $username)
//                        .padding(.top)
//                        .autocapitalization(.none)
//                        .onChange(of: username) { newValue in
//                            let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-")
//                            let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
//                            username = String(filteredText.prefix(30))
//                        }
//                        Divider()
                    }
                    .padding([.leading, .trailing])
                }
                .padding()
                .padding(.bottom, 20)
                
                Image("zoeChat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
                    .padding(.bottom, 15)
            
                //NavigationLink(destination: SetUpInicial2(username: $username, name: $name, onboarding:
                NavigationLink(destination: SetUpInicial2(name: $name, onboarding: $onboarding).navigationBarBackButtonHidden(true), label: {
                        ZStack {
                            Rectangle()
                                .fill(Color("primary"))
                                .cornerRadius(30)
                                .frame(width: 125, height: 39)
                            Text("Continuar")
                                .foregroundColor(.white)
                        }
                    })
                .disabled(name == "")
                .opacity(name == "" ? 0.6 : 1)
                //.disabled(username == "")
                //.opacity(username == "" ? 0.6 : 1)
            }
            .font(.system(size: 17))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .background(Color("backgroundColor"))
    }
}
