import SwiftUI
import CloudKit
import Combine

class FolderViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var books: [Book] = []
    @EnvironmentObject var userManager: UserManager
    
        var firstBooks: [Book] {
            if books.count == 1 {
                return [books[0]]
            } else if books.count == 2 {
                return [books[0], books[1]]
            } else if books.count > 2 {
                return [books[0], books[1], books[3]]
            }
            return []
        }
    
    private let bookService: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    var livro: Book = Book()
    
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
                self.livro = book
            })
            .store(in: &subscriptions)
        return self.livro
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
                    self.books.append(book)
                })
                .store(in: &subscriptions)
            
            
        }
    }
    
    
    
    
}
