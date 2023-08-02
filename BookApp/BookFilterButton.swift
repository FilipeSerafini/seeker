import SwiftUI

struct ButtonTeste: View {
    enum FilterType {
        case genero, titulo, autor
    }
    
    @State private var selectedFilter: FilterType?
    
    var body: some View {
        HStack {
            Button(action: {
                selectedFilter = .genero
            }) {
                Text("Gênero")
            }.buttonStyle(BookFilterButton(isFilled: Binding(get: { selectedFilter == .genero }, set: { newValue in
                if newValue {
                    selectedFilter = .genero
                } else {
                    selectedFilter = nil
                }
            })))
            
            Button(action: {
                selectedFilter = .titulo
            }) {
                Text("Título")
            }.buttonStyle(BookFilterButton(isFilled: Binding(get: { selectedFilter == .titulo }, set: { newValue in
                if newValue {
                    selectedFilter = .titulo
                } else {
                    selectedFilter = nil
                }
            })))
            
            Button(action: {
                selectedFilter = .autor
            }) {
                Text("Autor")
            }.buttonStyle(BookFilterButton(isFilled: Binding(get: { selectedFilter == .autor }, set: { newValue in
                if newValue {
                    selectedFilter = .autor
                } else {
                    selectedFilter = nil
                }
            })))
        }
    }
}

struct ButtonTeste_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTeste()
    }
}

struct BookFilterButton: ButtonStyle {
    var isFilled: Binding<Bool> // Estado do botão

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17))
            .frame(maxWidth: 99, maxHeight: 35)
            .foregroundColor(.black)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.6196078431372549, green: 0.6235294117647059, blue: 0.9215686274509803), lineWidth: 3)
                    .background(isFilled.wrappedValue ? Color(red: 0.6196078431372549, green: 0.6235294117647059, blue: 0.9215686274509803) : Color.clear)
            )
            .cornerRadius(20)
            .onTapGesture {
                isFilled.wrappedValue.toggle() //alterna o valor do botão entre preenchido e nao preenchido quando o botão é clicado
            }
            .padding(.horizontal, 5)
    }
}

