import SwiftUI

struct BookFolder: View {
     var body: some View {
         VStack{

             Text("Folders")
                 .font(.largeTitle)
                 .fontWeight(.semibold)
                 .frame(maxWidth: .infinity, alignment: .center)

             ScrollView(.vertical, showsIndicators: false) {

                 VStack(spacing: 0) {

                     ForEach(folders) {folder in
                         FolderView(folder: folder)
                     }
                 }
             }
         }
         .padding([.horizontal, .trailing])
     }

     @ViewBuilder
     func FolderView(folder: FolderInfo)->some View{
         GeometryReader {proxy in

             ZStack {

                 Image(folder.image)
                     .resizable()
                     .frame(width: 362, height: 647)
 //                    .aspectRatio(contentMode: .fit)
                 Text("Livros lidos")
                     .font(.system(size: 24, design: .serif))
                     .padding(.bottom, 570)
 //            }
 //        }
             }
         }
 //        .padding()
 //        .padding(.bottom,10)
 //    }
 //}
         .padding(.bottom,120)
     }
 }

 struct BookFolder_Previews: PreviewProvider {
     static var previews: some View {
         BookFolder()
     }
 }
