import SwiftUI

struct FolderCardView: View {
    
    @EnvironmentObject var libraryViewModel: LibraryViewModel

    let folder: Folder
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        
        VStack{

                //arrumar para buscar livros de cada folder
                
                ForEach(libraryViewModel.books) { book in
                    BookResearchedCover(book: book)
                }
            
            
            Button {
                #warning("Excluir pasta funcionar com o banco")
                //excluir pasta
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.red)
//                        .fill(Color("primary"))
                        .cornerRadius(22)
                        .frame(width: 125, height: 39)
                    Text("Apagar pasta")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(folder.name)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing){
                
                NavigationLink(destination: UserSettings(), label: {
                    Image("pencil")
                })
            }
        }
        
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing){
//                
//                NavigationLink(destination: UserSettings(), label: {
//                    Image("pencil")
//                })
//            }
//        }
    }
}

//struct FolderCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCardView()
//    }
//}
