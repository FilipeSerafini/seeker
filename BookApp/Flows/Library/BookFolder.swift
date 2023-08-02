//import SwiftUI
//
//struct BookFolder: View {
//    var body: some View {
//        
//        VStack{
//            Text("Folders")
//                .font(.largeTitle)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            ScrollView(.vertical, showsIndicators: false){
//                
//                VStack(spacing: 0) {
//                    ForEach(folders) {fonder in
//                        
//                    }
//                    
//                }
//            }
//        }
//        .padding([.horizontal, .trailing])
//        
//        
//    }
//    
//    @ViewBuilder
//    func FolderView(folder: Folder)->some View{
//        GeometryReader {proxy in
//            
//            ZStack(alignment: .bottomLeading) {
//                
//                Image("folderShape")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
//        }
//        .padding()
//        .padding(.bottom,10)
//    }
//}
//
//struct BookFolder_Previews: PreviewProvider {
//    static var previews: some View {
//        BookFolder()
//    }
//}
