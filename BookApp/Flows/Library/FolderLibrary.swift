import SwiftUI

struct FolderLibrary: View {
    
    var body: some View {
        
        FolderView(folder: folders[0])
    }
}

func FolderView(folder: FolderCard)->some View{
    
    GeometryReader {proxy in
        
        let rect = proxy.frame(in: .named("SCROLL"))
        
        // display some portion of each folder
        let offset =  -rect.minY + CGFloat(getIndex(folder: folder) * 70)
        
        ZStack {
            Image(folder.image)
                .resizable()
                .frame(width: 362, height: 647)
            //                    .aspectRatio(contentMode: .fit)
            
            // MARK: nome da pasta
            //            Text("Livros lidos")
            //                .font(.system(size: 24, design: .serif))
            //                .padding(.bottom, 570)
            //            }
            //        }
            //MARK: Making it as a stack
                .offset(y: -rect.minY)
        }
    }
    //        .padding()
    //        .padding(.bottom,10)
    //    }
    //}
    .padding(.bottom,120)
}

//Retreiving Index
func getIndex(folder: FolderCard)->Int{
    return folders.firstIndex { currentFolder in
        return currentFolder.id == folder.id
    } ?? 0
}
    
