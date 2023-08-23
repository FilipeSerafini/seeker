import SwiftUI
import Foundation

struct RecommendedView: View {
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    @EnvironmentObject private var selectedGenres: SelectedGenres
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    if !recommendedViewModel.firstList.isEmpty {
                        Text("Livros de \(selectedGenres.genresUser[0])")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .padding(.leading)
                        Spacer()
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0){
                        ForEach(recommendedViewModel.firstList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(.bottom)
            
            VStack {
                HStack {
                    if !recommendedViewModel.secondList.isEmpty{
                        Text("Livros de \(selectedGenres.genresUser[1])")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .padding(.leading)
                        Spacer()
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0){
                        ForEach(recommendedViewModel.secondList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                HStack {
                    if !recommendedViewModel.thirdList.isEmpty {
                        Text("Mais de \(selectedGenres.genresUser[2])")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .padding(.leading)
                        Spacer()
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(recommendedViewModel.thirdList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .padding(.bottom)
    }
}
