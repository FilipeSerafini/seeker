import SwiftUI

struct LibraryView: View {
    
    var userName: String = ""
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @ObservedObject private var viewModel: LibraryViewModel = LibraryViewModel()
    
    var body: some View {
        VStack{
            HStack{
                VStack (alignment: .leading){
                    Text("E aí, \(userName)?")
                        .font(.system(size: 15, design: .serif))
                    
                    Text("Minha Estante")
                        .font(.system(size: 34, design: .serif))
                }
                Spacer()
                
                Button {
                    //completar
                }
            label: {
                Image("addFolders")
                    .resizable()
                    .frame(width: 46, height: 34)
            }
            }
            .padding()
            .padding(.bottom, 500)
            
            ScrollView {
                ForEach(viewModel.folders.indices, id: \.self) { index in
                    VStack {
                        Text(viewModel.folders[index].name)
                        
                        Text(viewModel.folders[index].description)
                    }
                    .padding()
                    .background(Color.teal)
                }
            }
        }
    }
}
//
//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView(userName: "Schar")
//    }
//}
