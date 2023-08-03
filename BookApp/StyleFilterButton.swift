import SwiftUI

struct FilterButton: View {
    enum FilterType {
        case genero, titulo, autor, geral
    }
    
    @State private var selectedFilter: FilterType?
    
    var body: some View {
        HStack {
            Button(action: {
                selectedFilter = .genero
            }) {
                Text("Gênero")
            }.buttonStyle(
                StyleFilterButton(
                    isFilled: Binding(get: { selectedFilter == .genero },
                                      set: { newValue in
                                          if newValue {
                                              selectedFilter = .genero
                                          } else {
                                              selectedFilter = .geral
                                          }
                                      })))
            
            Button(action: {
                selectedFilter = .titulo
            }) {
                Text("Título")
            }.buttonStyle(
                StyleFilterButton(
                    isFilled: Binding(get: { selectedFilter == .titulo },
                                      set: { newValue in
                                          if newValue {
                                              selectedFilter = .titulo
                                          } else {
                                              selectedFilter = .geral
                                          }
                                      })))
            
            Button(action: {
                selectedFilter = .autor
            }) {
                Text("Autor")
            }.buttonStyle(StyleFilterButton(isFilled: Binding(get: { selectedFilter == .autor }, set: { newValue in
                if newValue {
                    selectedFilter = .autor
                } else {
                    selectedFilter = .geral
                }
            })))
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
    }
}

struct StyleFilterButton: ButtonStyle {
    @Environment(\.colorScheme) var scheme
    var isFilled: Binding<Bool> // Estado do botão
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            configuration.label
                .font(.system(size: 17))
                .foregroundColor(scheme == .light ? .black : .white)
                .frame(width: 99, height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.6196078431372549, green: 0.6235294117647059, blue: 0.9215686274509803), lineWidth: 3)
                        .background(isFilled.wrappedValue ? Color(red: 0.6196078431372549, green: 0.6235294117647059, blue: 0.9215686274509803) : Color.clear)
                )
                .cornerRadius(20)
                .onTapGesture {
                    isFilled.wrappedValue.toggle() //alterna o valor do botão entre preenchido e não preenchido quando o botão é clicado
                }
        }
        .padding(.horizontal, 10)
    }
}

