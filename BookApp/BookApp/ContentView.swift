
import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    @StateObject private var recommendedViewModel = RecommendedViewModel()
    
    var body: some View {
        ZStack {
            if self.isActive {
                //                FolderRow(folder: Folder(books: [], description: "a", name: "Livros que quero ler")!, imageName: "folderSelected")
                //                addToFolderHeader()
                TabViewApp()
                    .environmentObject(UserCRUD())
                    .environmentObject( UserManager())
                    .environmentObject(recommendedViewModel)
            } else {
                Preview()
            }
        }
        .onAppear {
            recommendedViewModel.fetchAll(searchedText: "Young Adult Fiction", "Romance", "Rupi Kaur", filter: .genre, .author)
#warning("mudar tempo para 1.5")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
