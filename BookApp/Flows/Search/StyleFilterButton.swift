import SwiftUI

struct FilterButton: View {
    @State var selectedFilter: Filter = .empty
    
    var body: some View {
        HStack {
            Button(action: {
                selectedFilter = .genre
            }) {
                Text("Gênero")
            }.buttonStyle(
                StyleFilterButton(
                    isFilled: Binding(get: { selectedFilter == .genre },
                                      set: { newValue in
                                          if newValue {
                                              selectedFilter = .genre
                                          } else {
                                              selectedFilter = .genre
                                          }
                                      })))
            
            Button(action: {
                selectedFilter = .title
            }) {
                Text("Título")
            }.buttonStyle(
                StyleFilterButton(
                    isFilled: Binding(get: { selectedFilter == .title },
                                      set: { newValue in
                                          if newValue {
                                              selectedFilter = .title
                                          } else {
                                              selectedFilter = .title
                                          }
                                      })))
            
            Button(action: {
                selectedFilter = .author
            }) {
                Text("Autor")
            }.buttonStyle(StyleFilterButton(isFilled: Binding(get: { selectedFilter == .author }, set: { newValue in
                if newValue {
                    selectedFilter = .author
                } else {
                    selectedFilter = .author
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
    var isFilled: Binding<Bool> // Estado do botão
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            configuration.label
                .font(.system(size: 17))
                .foregroundColor(Color("text"))
                .frame(width: 99, height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("primary"), lineWidth: 3)
                        .background(isFilled.wrappedValue ? Color("primary") : Color.clear)
                )
                .cornerRadius(20)
                .onTapGesture {
                    isFilled.wrappedValue.toggle()
                }
        }
        .padding(.horizontal, 10)
    }
}

