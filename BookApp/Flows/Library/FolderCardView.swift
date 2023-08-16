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
            
            Button {
                isPresented.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.clear)
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
                            .foregroundColor(Color("text"))
                    }
                }
            }
            .alert("Tem certeza que deseja apagar essa pasta?", isPresented: $isPresented) {
                Button("Cancelar",action: {})
                Button("Apagar",action: {
                    //acao de apagar a pasta
                    #warning("Excluir pasta funcionar com o banco")
                })
            } message: {
                Text("Essa ação não poderá ser desfeita.")
            }
        }
        .padding(.top, 10)
        .padding(.bottom)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
    }
}

//struct FolderCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderCardView()
//    }
//}
