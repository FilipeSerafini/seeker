import SwiftUI

struct FolderView: View {
    @State var navigateToFolder: Bool = false
    @StateObject var folderViewModel: FolderViewModel = FolderViewModel()
    @EnvironmentObject var userManager: UserManager
    var folder: Folder
    
    var body: some View {
        let background = getIndex(folder: folder).isMultiple(of: 2) ? Color("primary2") : Color("secondary")
        NavigationStack {
            NavigationLink {
                FolderCardView(folder: folder)
                    .environmentObject(folderViewModel)
            } label: {
                ZStack {
                    RoundedRectangle (cornerRadius: 20)
                        .fill(background)
                        .frame(width: 358, height: 205)
                    VStack {
                        Text(folder.name)
                            .font(.system(size: 24, weight: .medium, design: .serif))
                            .foregroundColor(.black)
                            .padding(.all, 10)
                    }
                    .frame(width: 350, height: 200, alignment: .topLeading)
                    
                    VStack {
                        HStack(spacing: 20) {
                            ForEach(folderViewModel.books.prefix(3)) { book in
                                BookImage(book: book)
                            }
                        }
                    }
                    .padding(.all, 10)
                    .frame(width: 350, height: 190, alignment: .bottomLeading)
                    
                    RoundedRectangle (cornerRadius: 20)
                        .fill(.white.opacity(0.01))
                        .frame(width: 358, height: 205)
                }
            }
            .onAppear {
                folderViewModel.fetchBooks(bookIDs: folder.books)
            }
        }
    }
    
    func getIndex(folder: Folder)->Int{
        return userManager.folders.firstIndex { currentFolder in
            return currentFolder.id == folder.id
        } ?? 0
    }
}
