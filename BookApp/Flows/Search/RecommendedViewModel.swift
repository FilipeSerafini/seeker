import Foundation
import Combine
import SwiftUI

class RecommendedViewModel: ObservableObject {
    @Published var firstList: [Book] = []
    @Published var secondList: [Book] = []
    @Published var thirdList: [Book] = []
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    private var currentPag: Int = 0
    
    func fetchAll(searchedText: String..., filter: Filter...) {
        let list1 = self.service.fetchBooks(searchedText: searchedText[0], page: self.currentPag, filter: filter[0])
            .mapAPIBookToBook()
            .setBookImages(withService: self.service)
        
        let list2 = self.service.fetchBooks(searchedText: searchedText[1], page: self.currentPag, filter: filter[0])
            .mapAPIBookToBook()
            .setBookImages(withService: self.service)
        
        let list3 = self.service.fetchBooks(searchedText: searchedText[2], page: self.currentPag, filter: filter[1])
            .mapAPIBookToBook()
            .setBookImages(withService: self.service)
        
        list1
            .zip(list2, list3)
            .sink(receiveCompletion: { _ in }, receiveValue: { list1, list2, list3 in
                self.firstList = list1
                self.secondList = list2
                self.thirdList = list3
            })
            .store(in: &subscriptions)
    }
}

extension Publisher where Output == [APIBook] {
    func mapAPIBookToBook() -> AnyPublisher<[Book], Error> {
        self
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
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == [Book] {
    func setBookImages(withService service: BookService) -> AnyPublisher<[Book], Error> {
        self
            .flatMap({ apiBooks in
                apiBooks.publisher
            })
            .flatMap({ book in
                if book.image != "image" {
                    return service.fetchBookCover(forURL: book.image)
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
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}
