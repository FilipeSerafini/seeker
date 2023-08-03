import SwiftUI

struct BookView: View {
    
    @State var book: Book
    
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .padding(.top, 300)
                    .ignoresSafeArea()
                
                VStack{
                    ZStack {
                        Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                            .resizable()
                            .frame(width: 170, height: 244)
                            .cornerRadius(15)
                    }
                    VStack {
                        Text (book.authors[0])
                            .textCase(.uppercase)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.bottom, 2)
                            .padding(.top, 2)
                        Text (book.title)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                            .frame(alignment: .center)
                            .padding(.bottom, 5)
                            .padding(.top, 2)
                        
                        Text("  Avaliação geral: \(book.rating)  ")
                            .background(Rectangle().fill(Color.black).cornerRadius(20).frame(height: 30))
                            .foregroundColor(.white)
                            .font(.system(size: 13))
                        
                        HStack {
                            
                            Button {
                                showSheet.toggle()
                            }
                        label: {
                            VStack{
                                Image("addBookToFolder")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Adicionar")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                            
                        .sheet(isPresented: $showSheet) {
                            addToFolderView()
                                
                        }
                        
                            
                            Spacer()
                            Button {
                                //completar
                            }
                        label: {
                            VStack{
                                Image("bookReadCheckbox")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Lido")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.trailing, 15)
                            Spacer()
                            Button {
                                //completar
                            }
                        label: {
                            VStack{
                                HStack{
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .padding(.leading, -2)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .padding(.leading, -4)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .padding(.leading, -4)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .padding(.leading, -4)
                                }
                                Text("Minha avaliação")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        
                        ScrollView{
                            Text (book.sinopsis)
                                .font(.system(size: 17, weight: .regular))
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                Button {}
            label: {
#warning("se o livro estiver nas listas Lendo agora e/ou Leituras realizadas, pode ser compartilhado no Insta")
                Image("shareButton")
                
            }
            }
        }
        .background(.black)
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(book: bookTeste!)
//    }
//}



//NavigationLink {
//    addToFolderView()
//} label: {
//    Image("addBookToFolder")
//        .resizable()
//        .frame(width: 40, height: 40)
//    Text("Adicionar")
//        .font(.system(size: 13))
//        .foregroundColor(.black)
//}
