import SwiftUI

struct LibraryView: View {
    
    var userName: String = ""
    @EnvironmentObject private var searchViewModel: SearchViewModel
    var body: some View {
        ZStack{
            HStack{
                VStack (alignment: .leading){
                    Text("What's up, \(userName)?")
                        .font(.system(size: 15, design: .serif))
                    
                    Text("My bookshelf")
                        .font(.system(size: 34, design: .serif))
                }
                Spacer()
                Image("profileImage")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            .padding()
            .padding(.bottom, 500)
        }
//        .navigationTitle("My bookshelf")
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(userName: "Schar")
    }
}
