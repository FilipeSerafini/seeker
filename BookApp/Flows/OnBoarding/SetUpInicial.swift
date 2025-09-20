import SwiftUI

struct SetUpInicial: View {
    @State var name = ""
    @AppStorage("firstTimeHere") private var showOnboarding = true
    
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
            
                NavigationLink(destination: SetUpInicial2(name: $name).navigationBarBackButtonHidden(true), label: {
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
