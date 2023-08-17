import SwiftUI

struct UserSettings: View {
    @State private var nameText = ""
    //@State private var usernameText = ""
    @State private var bioText = ""
    @Binding var myName: String
    //@Binding var myUsername: String
    @Binding var myBio: String
    let characterLimitBio = 150
    @Environment(\.dismiss) var dismiss
    
    init(myName: Binding<String>, myBio: Binding<String>) {
        _myName = myName
        _nameText = State(initialValue: myName.wrappedValue)
       // _myUsername = myUsername
       // _usernameText = State(initialValue: myUsername.wrappedValue)
        _myBio = myBio
        _bioText = State(initialValue: myBio.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ProfilePhoto()
                    .padding(.bottom, 30)
                HStack{
                    VStack(alignment: .leading) {
                        Text("Nome")
                            .padding(.bottom, 20)
//                        Text("Username")
//                            .padding(.bottom, 20)
                        Text("Bio")
                            .padding(.bottom)
                    }
                    
                    VStack{
                        TextField("Nome", text: $nameText)
                            .onChange(of: nameText) { newValue in
                                let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'ˆ`˜áàãâéèêíìóòôõúùçÁÀÃÂÉÈÊÍÌÓÒÔÕÚÙÇ ")
                                let filteredText = newValue.filter { allowedCharacterSet.contains(UnicodeScalar(String($0))!) }
                                nameText = String(filteredText.prefix(25))
                            }

                        Divider()
                            .padding(.bottom, 10)
                        
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

                        TextField("Bio", text: $bioText, axis: .vertical)
                            .lineLimit(2)
                            .frame(maxHeight: 40)
                            .onChange(of: bioText) { newValue in
                                if newValue.count > characterLimitBio {
                                    bioText = String(newValue.prefix(characterLimitBio))
                                }
                            }
                        Divider()
                    }
                    .padding([.leading, .trailing])
                }
                HStack{
                    Spacer()
                    Text("\(characterLimitBio - bioText.count)")
                        .font(.system(size: 15))
                        .foregroundColor(Color("textNote"))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.trailing)
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            .font(.system(size: 17))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    UserDefaults.standard.set(nameText, forKey: "name")
                   // UserDefaults.standard.set(usernameText, forKey: "username")
                    UserDefaults.standard.set(bioText, forKey: "bio")
                    
                    myName = nameText
                   // myUsername = usernameText
                    myBio = bioText
                    dismiss()
                }
            label: {
                Image("saveFolder")
            }
            }
        }
    }
}
