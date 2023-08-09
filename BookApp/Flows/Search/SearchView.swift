import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
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
