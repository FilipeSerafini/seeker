import SwiftUI

struct FolderCardView: View {
    
    @EnvironmentObject var folderViewModel: FolderViewModel
    
    let folder: Folder
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        VStack{
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(folderViewModel.books) { book in
                    BookResearchedCover(book: book)
                }
            }
            
            Button {
#warning("Excluir pasta funcionar com o banco")
                //excluir pasta
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(22)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .fill(.red)
                        }
                        .frame(width: 126, height: 36)
                    HStack{
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                        Text("Apagar pasta")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 30)
        
        Spacer()        
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(folder.name)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: ProfileView(), label: {
                        Image("pencil")
                    })
                }
            }
    }
}

//struct FolderCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCardView()
//    }
//}
