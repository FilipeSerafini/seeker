import SwiftUI

struct FolderView: View {
    @State var expandFolder: Bool = false

    var folder: FolderCard
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("SCROLL"))
            // display some portion of each folder
            let offset = CGFloat(getIndex(folder: folder) * (expandFolder ? 10 : 50))
            let background = getIndex(folder: folder).isMultiple(of: 2) ? Color("primary") : Color("secondary")
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
            
            ZStack(alignment: .bottom) {
                RoundedRectangle (cornerRadius: 20)
                    .fill(background)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .fill(.white)
                    }
                    .frame(width: 362, height: 647)
                
                ScrollView {
                    Text("Livros lidos")
                        .font(.system(size: 24, design: .serif))
                        .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(folder.books) { folderBook in
                            BookResearchedCover(book: folderBook)
                        }
                    }
                }
                .frame(maxHeight: 647)
            }
            .overlay {
                //Avoid scrolling
                Rectangle()
                    .fill(.black.opacity(expandFolder ? 0.01 : 0.01))
                    .onTapGesture {
                        if expandFolder {
                            withAnimation(.easeOut(duration: 0.35)){
                                expandFolder = false
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.35)){
                                expandFolder = true
                            }
                        }
                    }
            }
            //MARK: Making it as a stack
            .offset(y: expandFolder ? offset : -rect.minX + offset)
        }
        .padding(.bottom, 30)
        //.offset(y: 200)
    }
    func getIndex(folder: FolderCard)->Int{
        return folders.firstIndex { currentFolder in
            return currentFolder.id == folder.id
        } ?? 0
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
