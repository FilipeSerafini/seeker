import Foundation
import Combine
import SwiftUI

private enum State: Comparable {
    case isLoading
    case alreadyLoaded
}

class RecommendedViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    private var currentState: State = .alreadyLoaded
    private var currentPag: Int = 0
    private var currentSearch: String = ""
    
    func fetchBooks(searchedGenre: String) {
        
        if currentState == .isLoading {
            return
        }
        
        currentState = .isLoading
        
        self.service.fetchBooks(searchedText: searchedGenre, page: currentPag)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .compactMap({ apiBook -> Book in
                let newBook = Book(authors: apiBook.authors, genres: apiBook.genres ?? [], image: apiBook.image?.thumbnail ?? "image", isbns: apiBook.isbns.map(\.identifier), rating: apiBook.rating?.description ?? "", sinopsis: apiBook.sinopsis ?? "", title: apiBook.title, imageCover: nil)
                return newBook!
            })
            .collect()
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .flatMap({ book in
                if book.image != "image" {
                    return self.service.fetchBookCover(forURL: book.image)
                        .map({ data in
                            var newBook = book
                            newBook.imageCover = UIImage(data: data)
                            return newBook
                        })
                        .replaceError(with: book)
                        .eraseToAnyPublisher()
                }
                else {
                    var newBook = book
                    newBook.imageCover = UIImage(named: "bookImage")
                    return Just(newBook).eraseToAnyPublisher()
                }
            })
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { books in
                self.books = self.books + books
                self.currentPag += 10
                self.currentState = .alreadyLoaded
            })
            .store(in: &subscriptions)
    }
}

