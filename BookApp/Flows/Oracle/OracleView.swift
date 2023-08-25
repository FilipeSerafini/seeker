import SwiftUI

struct OracleView: View {
    @State var messages: [String] = []
    @State private var isTyping = false
    @State private var isEditing: Bool = false
    @State private var isTextFieldFocused = false
    @State private var sendToAPI: String = ""
    @State private var inputUsuario: String = ""
    @State private var oracleResponse: String?
    @State private var service: OracleService = OracleService()
    @State private var isMovingUp = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    ZStack{
                        VStack {
                            Text("Zoe")
                                .font(.system(size: 22, design: .serif))
                                .padding(.top, 10)
                        }
                    }
                    
                    if !isEditing && messages.isEmpty {
                        VStack{
                            Spacer()
                            Image("zoeChat")
                                .resizable()
                                .frame(width: 350, height: 261)
                                .padding(.top, geometry.size.height/6)
                                .offset(y: isMovingUp ? 20 : 0)
                                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isMovingUp)
                            
                            Text("Olá, eu sou Zoe, seu oráculo literário! Estou aqui para te ajudar a descobrir tudo que quer saber sobre o mundo da leitura. Você pode me perguntar qualquer coisa relacionada a livros!")
                                .font(.system(size: 15))
                                .multilineTextAlignment(.center)
                                .frame(width: geometry.size.width/1.15, height: geometry.size.height/8)
                        }
                        .onAppear() {
                            self.isMovingUp.toggle()
                        }
                    }
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(messages, id: \.self) { message in
                            if message.contains("[USER]") {
                                let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                HStack {
                                    Spacer()
                                    Text(newMessage)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(Color("primary"))
                                        .clipShape(ChatBubble(corners: [.topLeft, .topRight, .bottomLeft]))                  .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                }
                            } else {
                                HStack {
                                    Text(message)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(Color("secondary"))
                                        .clipShape(ChatBubble(corners: [.topLeft, .topRight, .bottomRight]))
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }
                            }
                        }
                        .rotationEffect(Angle(degrees: 180))
                    }
                    .rotationEffect(Angle(degrees: 180))
                    
                    if isTyping {
                        LoadingOracle()
                    }
                    
                    HStack {
                        TextField("O que você gostaria de saber?", text: $inputUsuario, onEditingChanged: { editing in
                            isEditing = editing
                        })
                        .padding()
                        .padding(.trailing, 30)
                        .font(.system(size: 15))
                        .background(Color("textField"))
                        .cornerRadius(30)
                        .onTapGesture {
                            isTextFieldFocused = true
                        }
                        .onSubmit {
                            if inputUsuario != "" {
                                sendMessage(message: inputUsuario)
                            }
                        }
                        .overlay(
                            HStack {
                                Spacer()
                                Button {
                                    if inputUsuario != ""{
                                        sendMessage(message: inputUsuario)
                                    }
                                } label: {
                                    Image("paperplane")
                                        .resizable()
                                        .frame(width: 28, height: 26)
                                        .padding(.trailing, 15)
                                }
                                .disabled(inputUsuario == "")
                                .opacity(inputUsuario == "" ? 0.6 : 1)
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            })
                    }
                    .padding()
                }
                .background(
                    Image("backgroundImage")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                )
                .background(Color("backgroundColor"))
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            sendToAPI = inputUsuario
            self.inputUsuario = ""
            isTyping = true
        }
        
        Task.init(priority: .userInitiated, operation: {
            let message = await self.service.sendRequest(messageString: sendToAPI)
            oracleResponse = message.content
            DispatchQueue.main.async {
                withAnimation {
                    messages.append(oracleResponse ?? "")
                    isTyping = false
                }
            }
        })
    }
}

struct OracleView_Previews: PreviewProvider {
    static var previews: some View {
        OracleView()
    }
}
