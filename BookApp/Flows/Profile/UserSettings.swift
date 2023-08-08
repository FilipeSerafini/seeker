import SwiftUI

struct UserSettings: View {
    
    @State private var nameText = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        
        NavigationView {
            
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
            } .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {}
                label: {
                    Image("saveFolder")
                }
                }
            }
            .padding(.top, 60)
            .padding()
        }
    }
}

struct UserSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserSettings()
    }
}
