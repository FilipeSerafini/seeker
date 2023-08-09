import SwiftUI

struct UserSettings: View {
    @State private var nameText = ""
    @State private var usernameText = ""
    @State private var bioText = ""
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                Image("usuariaTeste")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
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
                        TextField("Nome", text: $nameText, onEditingChanged: { editing in isEditing = editing
                        })
                        Divider()

                        TextField("username", text: $usernameText, onEditingChanged: { editing in isEditing = editing
                        })
                        Divider()

                        TextField("Bio", text: $bioText, axis: .vertical)
                           .lineLimit(2)
                           .frame(maxHeight: 40)
                        Divider()

                    }
                    .padding([.leading, .trailing])
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding([.leading, .trailing, .bottom])
            .font(.system(size: 17))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {}
            label: {
                Image("saveFolder")
            }
            }
        }
    }
}

struct UserSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserSettings()
    }
}
