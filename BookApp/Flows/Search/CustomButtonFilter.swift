import SwiftUI

struct CustomButtonFilter: ButtonStyle {
    var isSelected: Binding<Bool>
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            configuration.label
                .font(.system(size: 17))
                .foregroundColor(Color("text"))
                .frame(width: 99, height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("primary"), lineWidth: 3)
                        .background(isSelected.wrappedValue ? Color("primary") : Color.clear)
                )
                .cornerRadius(20)
                .onTapGesture {
                    isSelected.wrappedValue.toggle()
                }
        }
        .padding(.horizontal, 10)
    }
}

struct CustomButtonGenre: ButtonStyle {
    var isSelected: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color("text"))
            .font(.system(size: 17))
            .padding(.horizontal, 25)
            .frame(maxHeight: 36)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("genreButton"), lineWidth: 3)
                    .background(isSelected ? Color("genreButton") : Color.clear)
            )
            .cornerRadius(20)
    }
}
