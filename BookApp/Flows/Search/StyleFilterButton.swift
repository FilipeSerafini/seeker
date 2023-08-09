import SwiftUI

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

