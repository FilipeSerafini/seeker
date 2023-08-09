import SwiftUI

struct AddReview: View {
    @State var book: Book
    @State private var titleReview = ""
    @State private var addReview = ""
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Image(uiImage: book.imageCover ?? UIImage(named: "bookImage")!)
                            .resizable()
                            .frame(width: 62, height: 88)
                            .cornerRadius(10)
                           // .shadow(color: Color.black.opacity(0.25), radius: 3.2, x: 0, y: 3.2)
                    }
                    
                    VStack(alignment: .leading){
                        Text(book.authors[0])
                            .font(.system(size: 13))
                            .textCase(.uppercase)
                        Text(book.title)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                    .padding(.bottom, 30)
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Divider()
                    .padding(.horizontal)
                VStack{
                    TextField("Título da nota", text: $titleReview)
                        .textFieldStyle(.plain)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                    
                    ZStack(alignment: .leading) {
                        TextEditor(text: $addReview)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                            .padding(.leading, -3)
                        
                        if addReview.isEmpty{
                            VStack{
                                Text("Adicionar nota")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color("textNote"))
                                    .padding(.top, 10)
                                    .padding(.leading, 1)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {}
                label: {
                    Image("chevronBackward")
                        .resizable()
                        .frame(width: 15, height: 24)
                }
                }
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Adicionar nota")
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {}
                label: {
                    Image("saveFolder")
                }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button {}
            label: {
                Image("saveFolder")
            }
            }
        }
    }
}
