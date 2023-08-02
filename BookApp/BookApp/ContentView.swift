
import SwiftUI

struct ContentView: View {
@State private var isActive = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                TabViewApp()
                    .environmentObject(UserCRUD())
            } else {
                Preview()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
