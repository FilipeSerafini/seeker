import SwiftUI

struct BookView: View {
    @State var book: Book
    @State var showSheet: Bool = false
    
    @Environment(\.colorScheme) var scheme
    @Environment(\.presentationMode) private var presetationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            NavigationStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(scheme == .light ? .white : .black)
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
                            ScrollView(showsIndicators: false){
                                
                                Text (book.authors[0])
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(scheme == .light ? .black : .white)
                                    .textCase(.uppercase)
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.bottom, 1)
                                
                                Text (book.title)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 22, weight: .medium, design: .serif))
                                    .foregroundColor(scheme == .light ? .black : .white)
                                    .frame(alignment: .center)
                                    .padding(.bottom, 5)
                                    .padding(.top, 1)
                                
                                Text("  Avaliação geral: \(book.rating)  ")
                                    .background(Rectangle().fill(scheme == .light ? Color.black : Color.white).cornerRadius(20).frame(height: 20))
                                    .foregroundColor(scheme == .light ? .white : .black)
                                    .font(.system(size: 13))
                                    .padding(.bottom, 8)
                                    .padding(.top, 4)
                                
                                // MARK: Barra de adicionar, lido e avaliação
                                
                                HStack{
                                    Button {
                                        showSheet.toggle()
                                    }
                                label: {
                                        VStack{
                                            Image("addBookToFolder")
                                                .resizable()
                                                .frame(width: 34, height: 34)
                                            Text("Adicionar")
                                                .font(.system(size: 13))
                                            .foregroundColor(scheme == .light ? .black : .white)                                        }
                                    }
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
                                        .foregroundColor(scheme == .light ? .black : .white)                                    }
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
                                        .foregroundColor(scheme == .light ? .black : .white)                                    }
                                }
                                .sheet(isPresented: $showSheet) {
                                    addToFolderView()
                                }
                                .padding(.bottom, 10)
                                
                                Text (book.sinopsis)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(scheme == .light ? .black : .white)
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            presetationMode.wrappedValue.dismiss()
                        }) {
                            Image("chevronBackward")
                                .resizable()
                                .frame(width: 16, height: 24)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {}
                    label: {
                        // MARK: Se o livro estiver nas listas Lendo agora e/ou Leituras realizadas, pode ser compartilhado no Insta
                        Image("shareButton")
                    }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .background(scheme == .light ? .black : .white)
        }
    }
}
