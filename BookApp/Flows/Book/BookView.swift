import SwiftUI

struct BookView: View {
    
    var bookImage: String = ""
    var bookRating: String = ""
    var bookAuthor: String = ""
    var bookTitle: String = ""
    var bookSinopsis: String = ""
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .padding(.top, 300)
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack{
                        Button {
                            ShareInstagramView()
                        }
                    label: {
                        Image("shareButton")
                    }
                    }
                    .padding(.leading, 300)
                    
                    ZStack {
                        Image(bookImage)
                            .resizable()
                            .frame(width: 170, height: 244)
                            .cornerRadius(15)
                    }
                    .padding(.top, 60)
                    VStack {
                        Text (bookAuthor)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.bottom, 2)
                            .padding(.top, 2)
                        Text (bookTitle)
                            .font(.system(size: 34, weight: .medium, design: .serif))
                            .padding(.bottom, 5)
                            .padding(.top, 2)
                        
                        Text("  Avaliação geral: \(bookRating)  ")
                            .background(Rectangle().fill(Color.black).cornerRadius(20).frame(height: 30))
                            .foregroundColor(.white)

                        HStack{
                            Button {
                                //completar
                            }
                        label: {
                            VStack{
                                Image("addBookToFolder")
                                    .resizable()
                                    .frame(width: 43, height: 43)
                                Text("Adicionar")
                                    .foregroundColor(.black)
                            }
                        }
                            
                            Button {
                                //completar
                            }
                        label: {
                            VStack{
                                Image("bookReadCheckbox")
                                    .resizable()
                                    .frame(width: 43, height: 43)
                                Text("Lido")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.trailing, 15)
                            
                            Button {
                                //completar
                            }
                        label: {
                            VStack{
                                HStack{
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 37, height: 36)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 37, height: 36)
                                        .padding(.leading, -2)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 37, height: 36)
                                        .padding(.leading, -4)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 37, height: 36)
                                        .padding(.leading, -4)
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 37, height: 36)
                                        .padding(.leading, -4)
                                }
                                .padding(.top, 10)
                                Text("Minha avaliação")
                                    .foregroundColor(.black)
                            }
                        }
                        }
                        
                        ScrollView{
                            Text (bookSinopsis)
                                .font(.system(size: 17, weight: .regular))
                        }
                        .padding()
                    }
                }
            }
        }
        .background(.black)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(bookImage: "bookImage", bookRating: "4,5", bookAuthor: "BOOK AUTHOR",
                 bookTitle: "Book Title", bookSinopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
