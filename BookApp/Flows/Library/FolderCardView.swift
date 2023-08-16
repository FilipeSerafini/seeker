import SwiftUI

struct FolderCardView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var folderViewModel: FolderViewModel
    
    let folder: Folder
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(folderViewModel.books) { book in
                        BookResearchedCover(book: book)
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: FolderCardViewEdit(folder: folder)                    .environmentObject(folderViewModel)
                    , label: {
                    Image("pencil")
                })
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(folder.name)
                        .font(.system(size: 22, weight: .medium, design: .serif))
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
