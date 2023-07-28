import SwiftUI

struct GradientTabBarItem: View {
    var label: String
    var gradientColors: [Color]

    var body: some View {
        Text(label)
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
    }
}

struct teste: View {
    var body: some View {
        TabView {
            
            LibraryView()
                .tabItem {
                    Label("", systemImage: "books.vertical")
                }
            SearchView()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            
            Text("Second Tab")
                .tabItem {
                    GradientTabBarItem(label: "Second", gradientColors: [Color.blue, Color.purple])
                }
            
            Text("Third Tab")
                .tabItem {
                    GradientTabBarItem(label: "Third", gradientColors: [Color.green, Color.yellow])
                }
        }
        .accentColor(
        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
    }
    
}


struct teste_Previews: PreviewProvider {
    static var previews: some View {
        teste()
    }
}

