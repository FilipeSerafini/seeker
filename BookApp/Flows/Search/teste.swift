import SwiftUI

struct teste: View {
    @State private var isLinkActive = false
    
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                HStack{
                    VStack{
                        Image("bookImage")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 95, height: 136)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading){
                        Text("Ana")
                            .font(.system(size: 13))
                        Text("Flores no campo")
                            .font(.system(size: 22, weight: .medium, design: .serif))
                        Text("Blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla")
                            .font(.system(size: 15))
                    }
                }
                .onTapGesture {
                    isLinkActive = true
                }
            }
            .confirmationDialog("Are you sure?",
                                isPresented: $isPresentingConfirm) {
                Button("Ver detalhes", role: .destructive) {
                    //acao
                } } message: {
                    Text("Nome do livro")
                }
               
            
            
            
//                .navigationDestination(isPresented: $isLinkActive, destination: { BookView() })
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 140, alignment:
                .topLeading)
        .padding([.leading, .trailing])
        .padding(.bottom, 5)
    }
}

struct teste_Previews: PreviewProvider {
    static var previews: some View {
        teste()
    }
}
