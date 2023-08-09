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
                    Text("Nome")
                    TextField("Nome", text: $nameText, onEditingChanged: { editing in isEditing = editing
                    })
                    .padding(.leading, 45)
                }
                Divider()
                    .padding(.leading, 100)
                HStack{
                    Text("Username")
                    TextField("username", text: $usernameText, onEditingChanged: { editing in isEditing = editing
                    })
                    .padding(.leading, 12)

                }
                Divider()
                    .padding(.leading, 100)
                HStack{
                    Text("Bio")
                    TextField("Bio", text: $bioText, axis: .vertical)
                    .padding(.leading, 66)

                }
                Divider()
                    .padding(.leading, 100)
                
                Spacer()
            }
            .font(.system(size: 17))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {}
                label: {
                    Image("saveFolder")
                }
                }
            }
           .padding()
        }
    }
}

struct UserSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserSettings()
    }
}
