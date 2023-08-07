import SwiftUI


struct TESTE: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        
        ZStack {
            RoundedRectangle (cornerRadius: 20)
                .fill(.green)
                .frame(width: 362, height: 647)
            
        ScrollView {
            Text("Livros lidos")
                .font(.system(size: 24, design: .serif))
            //                .padding(.top, 10)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 647)
    }
    }
}

struct TESTE_Previews: PreviewProvider {
    static var previews: some View {
        TESTE()
    }
}
