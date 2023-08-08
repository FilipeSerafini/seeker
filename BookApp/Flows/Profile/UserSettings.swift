import SwiftUI

struct UserSettings: View {
    var body: some View {
        
        @State var nameText = ""
        @State var isEditing: Bool = false
        VStack{
            Image("usuariaTeste")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
            
            HStack{
                Text("Name")
                
                TextField("Manoela", text: $nameText, onEditingChanged: { editing in isEditing = editing
                })
            }
            HStack{
                Text("Username")
                TextField("Manoela", text: $nameText, onEditingChanged: { editing in isEditing = editing
                })
            }
            HStack{
                Text("BIO")
                TextField("Manoela", text: $nameText, onEditingChanged: { editing in isEditing = editing
                })
            }
            Spacer()
        }
        .padding(.top, 60)
        .padding()
    }
}

struct UserSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserSettings()
    }
}
