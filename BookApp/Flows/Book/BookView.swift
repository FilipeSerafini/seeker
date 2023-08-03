import SwiftUI

struct BookView: View {
    
    @State var book: Book
    
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack{
            NavigationStack{
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
                            ScrollView{
                                
                                Text (book.authors[0])
                                    .multilineTextAlignment(.center)
                                    .textCase(.uppercase)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.bottom, 1)
                                Text (book.title)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 22, weight: .medium, design: .serif))
                                    .frame(alignment: .center)
                                    .padding(.bottom, 5)
                                    .padding(.top, 1)
                                
                                Text("  Avaliação geral: \(book.rating)  ")
                                    .background(Rectangle().fill(Color.black).cornerRadius(20).frame(height: 20))
                                    .foregroundColor(.white)
                                    .font(.system(size: 13))
                                    .padding(.bottom, 8)
                                    .padding(.top, 4)
                                
// MARK: Barra de adicionar, lido e avaliação
                                
                                HStack{
                                    //.navigationBarBackButtonHidden(true)
                                    NavigationLink(destination: OracleView(), label: {
                                        VStack{
                                            Image("addBookToFolder")
                                                .resizable()
                                                .frame(width: 34, height: 34)
                                            Text("Adicionar")
                                                .font(.system(size: 13))
                                                .foregroundColor(.black)
                                        }
                                    })
                                    Spacer()
                                    
                                    Button {
                                        //completar
                                    }
                                label: {
                                    VStack{
                                        Image("bookReadCheckbox")
                                            .resizable()
                                            .frame(width: 34, height: 34)
                                        Text("Lido")
                                            .font(.system(size: 13))
                                            .foregroundColor(.black)
                                    }
                                }
                                    Spacer()

                                    VStack{
                                        HStack{
                                            Button {
                                                //completar
                                            }
                                        label: {
                                            Image("heart")
                                                .resizable()
                                                .frame(width: 34, height: 30)
                                        }
                                            Button {
                                                //completar
                                            }
                                        label: {
                                            Image("heart")
                                                .resizable()
                                                .frame(width: 34, height: 30)
                                        }
                                            Button {
                                                //completar
                                            }
                                        label: {
                                            Image("heart")
                                                .resizable()
                                                .frame(width: 34, height: 30)
                                        }
                                            Button {
                                                //completar
                                            }
                                        label: {
                                            Image("heart")
                                                .resizable()
                                                .frame(width: 34, height: 30)
                                        }
                                            Button {
                                                //completar
                                            }
                                        label: {
                                            Image("heart")
                                                .resizable()
                                                .frame(width: 34, height: 30)
                                        }
                                        }
                                        Text("Minha avaliação")
                                            .font(.system(size: 13))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.bottom, 10)
                                
                                Text (book.sinopsis)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .toolbar {
                    Button {}
                label: {
                    
// MARK: Se o livro estiver nas listas Lendo agora e/ou Leituras realizadas, pode ser compartilhado no Insta
                    Image("shareButton")
                    
                }
                }
            }
            .background(.black)
        }
    }
}
