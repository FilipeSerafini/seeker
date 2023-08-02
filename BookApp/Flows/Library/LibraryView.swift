import SwiftUI

struct LibraryView: View {
    
    var userName: String = ""
    @EnvironmentObject private var searchViewModel: SearchViewModel
    var body: some View {
        ZStack{
            HStack{
                VStack (alignment: .leading){
                    Text("E aí, \(userName)?")
                        .font(.system(size: 15, design: .serif))
                    
                    Text("Minha Estante")
                        .font(.system(size: 34, design: .serif))
                }
                Spacer()
                Image("addFolders")
                    .resizable()
                    .frame(width: 46, height: 34)
            }
            .padding()
            .padding(.bottom, 500)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(userName: "Schar")
    }
}
