import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            SearchableView()
                .navigationBarTitle("Buscar")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
