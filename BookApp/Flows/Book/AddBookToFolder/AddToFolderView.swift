import SwiftUI

struct AddToFolderView: View {
    
#warning("SPIKE: Expore data flow options for SwiftUI. Possibly, userManager will be (somehow) inside of a ViewModel")
    @EnvironmentObject private var userManager: UserManager
    //    @StateObject private var addToFolderViewModel: AddToFolderViewModel = AddToFolderViewModel()
    
    @State var book: Book
    @State var state: String = "folderUnselected"
    @State var modifiedFolders: [Folder] = []
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Text("Adicionar a uma lista")
                    .font(.system(size: 22, weight: .medium, design: .serif))
                Spacer()
                
                Button {
                    
                    userManager.updateFolders(folders: modifiedFolders) {
                        print("terminou")
                    }
                    //                    addToFolderViewModel.addBookToFolder(book: self.book)
                } label: {
                    Image("saveFolder")
                }
                Spacer()
                
            }
            .padding(.top)
            
            ForEach(userManager.folders) { folder in
                FolderRow(folder: folder, isSelected: folder.books.contains(book.id)) { isSelected, hasChanged in
#warning("FUTURE IMPROVEMENT: Refactor this piece of code for a ViewModel")
                    if hasChanged {
                        var updatedFolder = folder
                        
                        if isSelected {
                            updatedFolder.books.append(book.id)
                        } else {
                            updatedFolder.books.removeAll(where: { $0 == book.id })
                        }
                        
                        modifiedFolders.append(updatedFolder)
                    } else {
                        modifiedFolders.removeAll{ $0 == folder }
                    }
                }
                
                Divider()
            }
            
            Spacer()
        }
    }
}

//struct AddToFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToFolderView()
//    }
//}

