import Foundation
import Combine
import SwiftUI

private enum State: Comparable {
    case isLoading
    case alreadyLoaded
}

class SearchViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    private var currentState: State = .alreadyLoaded
    private var currentPag: Int = 0
    private var currentSearch: String = ""
    
    func fetchBooks(searchedText: String, filter: Filter) {
        
        if currentState == .isLoading {
            return
        }
        
        if searchedText != currentSearch {
            currentSearch = searchedText
            currentPag = 0
            books = []
        }
        
        print("pag: \(currentPag)")
        currentState = .isLoading
        
        self.service.fetchBooks(searchedText: searchedText, page: currentPag, filter: filter)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
//            .filter ({ apiBook in
//                if apiBook.sinopsis == nil || apiBook.title == nil {
//                    print("false")
//                    return false
//                } else {
//                    print("true")
//                    return true
//                }
//            })
            .compactMap({ apiBook -> Book in
                let newBook = Book(authors: apiBook.authors ?? ["N/A"], genres: apiBook.genres ?? ["N/A"], image: apiBook.image?.thumbnail ?? "image", isbns: apiBook.isbns?.map(\.identifier) ?? ["N/A"], rating: apiBook.rating?.description ?? "N/A", sinopsis: apiBook.sinopsis ?? "N/A", title: apiBook.title ?? "N/A", imageCover: nil)
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
