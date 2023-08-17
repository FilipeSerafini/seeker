import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
    var body: some View {
        NavigationStack {
            SearchableView()
                .environmentObject(searchViewModel)
                .environmentObject(selectedGenres)
                .navigationBarTitle("Buscar")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SelectedGenres())
            .environmentObject(SearchViewModel())
    }
}
