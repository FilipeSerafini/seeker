import SwiftUI

struct UserSettings: View {
    @EnvironmentObject private var auth: AuthService
    private let characterLimitBio: Int = 150
    @Binding var myName: String
    @Binding var myBio: String
    //@Binding var myUsername: String
    @State private var originalName = ""
    @State private var originalBio = ""
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ProfilePhoto()
                    .padding(.bottom, 30)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Nome")
                            .padding(.bottom, 20)
                        //                        Text("Username")
                        //                            .padding(.bottom, 20)
                        Text("Bio")
                            .padding(.bottom)
                    }
                    
                    VStack {
                        TextField("Nome", text: $myName)
                            .onChange(of: myName) { newValue in
                                let forbiddenCharacterSet = CharacterSet(charactersIn: "&$#@!%*()+=[]{}|;:'\",<>/?-_€£0123456789")
                                let filteredText = newValue.filter { !forbiddenCharacterSet.contains(UnicodeScalar(String($0))!)}
                                myName = String(filteredText.prefix(25))
                            }
                        
                        Divider()
                        
                        //                        TextField("Username", text: $usernameText)
                        //                            .autocapitalization(.none)
                        //                            .onChange(of: usernameText) { newValue in
                        //                                let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-")
                        //                                let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
                        //                                usernameText = String(filteredText.prefix(30))
                        //                            }
                        //
                        //                        Divider()
                        //                            .padding(.top, 5)
                        
                        TextField("Bio", text: $myBio, axis: .vertical)
                            .lineLimit(2)
                            .frame(maxHeight: 40)
                            .onChange(of: myBio) { newValue in
                                if newValue.count > characterLimitBio {
                                    myBio = String(newValue.prefix(characterLimitBio))
                                }
                            }
                        Divider()
                    }
                    .padding([.leading, .trailing])
                }
                HStack {
                    Spacer()

                    Text("\(characterLimitBio - myBio.count)")
                        .font(.system(size: 15))
                        .foregroundColor(Color("textNote"))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.trailing)
                Spacer()
                
                HStack {
                    Button("Desconectar") {
                        do {
                            try auth.signOut()
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                    Button("Trocar senha") {
                        Task {
                            do {
                                try await auth.resetPassword(email: auth.getCurrentUserEmail()) // maybe concurrency problem
                            } catch {
                                print("Error signing out: \(error)")
                            }
                        }
                    }
                }
                .padding(.trailing)
            }
            .padding([.leading, .trailing, .bottom])
            .font(.system(size: 17))
        }
        .onAppear {
            originalName = myName
            originalBio = myBio
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    UserDefaults.standard.set(myName, forKey: "name")
                    UserDefaults.standard.set(myBio, forKey: "bio")
                    // UserDefaults.standard.set(usernameText, forKey: "username")
                    
                    userManager.updateUser(name: myName, bio: myBio)

                    dismiss()
                }
            label: {
                Image("saveFolder")
            }
            .disabled(myName == originalName && myBio == originalBio)
            .opacity((myName != originalName || myBio != originalBio) ? 1.0 : 0.6)
            }
        }
    }
}

