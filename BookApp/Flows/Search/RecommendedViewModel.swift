import Foundation
import Combine
import SwiftUI

private enum State: Comparable {
    case isLoading
    case alreadyLoaded
}

class RecommendedViewModel: ObservableObject {
    @Published var firstList: [Book] = []
    @Published var secondList: [Book] = []
    @Published var thirdList: [Book] = []
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    private var currentState: State = .alreadyLoaded
    private var currentState2: State = .alreadyLoaded
    private var currentState3: State = .alreadyLoaded
    private var currentPag: Int = 0
    private var currentSearch: String = ""
    
    func fetchBooksFirst(searchedGenre: String, filter: Filter) {

        print("fazendo request primeira lista")

        if currentState == .isLoading {
            return
        }

        currentState = .isLoading

        self.service.fetchBooks(searchedText: searchedGenre, page: currentPag, filter: filter)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .filter ({ apiBook in
                return true
            })
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
                self.firstList = books
                self.currentPag += 10
                self.currentState = .alreadyLoaded
            })
            .store(in: &subscriptions)
    }

    func fetchBooksSecond(searchedGenre: String, filter: Filter) {

        print("fazendo request segunda lista")

        if currentState2 == .isLoading {
            return
        }

        currentState2 = .isLoading

        self.service.fetchBooks(searchedText: searchedGenre, page: currentPag, filter: filter)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .filter ({ apiBook in
                return true
            })
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
                self.secondList = books
                self.currentPag += 10
                self.currentState2 = .alreadyLoaded
            })
            .store(in: &subscriptions)
    }

    func fetchBooksThird(searchedGenre: String, filter: Filter) {

        print("fazendo request terceira lista")

        if currentState3 == .isLoading {
            return
        }

        currentState3 = .isLoading

        self.service.fetchBooks(searchedText: searchedGenre, page: currentPag, filter: filter)
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .filter ({ apiBook in
                return true
            })
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
                self.thirdList = books
                self.currentPag += 10
                self.currentState3 = .alreadyLoaded
            })
            .store(in: &subscriptions)
    }
}

