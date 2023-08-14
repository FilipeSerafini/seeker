import SwiftUI

struct UserSettings: View {
    @State private var nameText = ""
    @State private var usernameText = ""
    @State private var bioText = ""
    @Binding var myName: String
    @Binding var myUsername: String
    @Binding var myBio: String
    let characterLimitUsername = 10
    let characterLimitBio = 150
    @Environment(\.dismiss) var dismiss
    
    init(myName: Binding<String>, myUsername: Binding<String>, myBio: Binding<String>) {
        _myName = myName
        _nameText = State(initialValue: myName.wrappedValue)
        _myUsername = myUsername
        _usernameText = State(initialValue: myUsername.wrappedValue)
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
                            .padding(.bottom, 10)
                        Text("Username")
                            .padding(.bottom, 20)
                        Text("Bio")
                            .padding(.bottom)
                    }
                    
                    VStack{
                        TextField("Nome", text: $nameText)
                        Divider()
                        
                        TextField("username", text: $usernameText)
                            .onChange(of: usernameText) { newValue in
                                if newValue.count > characterLimitUsername {
                                    usernameText = String(newValue.prefix(characterLimitUsername))
                                }
                            }
                        Divider()
                        
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
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            .font(.system(size: 17))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    UserDefaults.standard.set(nameText, forKey: "name")
                    UserDefaults.standard.set(usernameText, forKey: "username")
                    UserDefaults.standard.set(bioText, forKey: "bio")

                    
                    myName = nameText
                    myUsername = usernameText
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
