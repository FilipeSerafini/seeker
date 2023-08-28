import SwiftUI
import CloudKit
import Combine

class FolderViewModel: ObservableObject {
    @Published var books: [Book] = []
    private let bookService: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    private var book: Book = Book()
    
    func fetchOneBook(bookID: String) -> Book {
        bookService.fetchBookById(bookId: bookID)
            .mapAPIBookToBook()
            .setBookImages(withService: bookService)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { book in
                self.book = book
            })
            .store(in: &subscriptions)
        return self.book
    }
    
    func fetchBooks(bookIDs: [String]) {
        bookIDs.forEach { bookID in
            bookService.fetchBookById(bookId: bookID)
                .mapAPIBookToBook()
                .setBookImages(withService: bookService)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        return
                    }
                }, receiveValue: { book in
                    if !self.books.contains(where: {$0.id == book.id}) {
                        self.books.append(book)
                    }
                })
                .store(in: &subscriptions)
        }
    }
}
