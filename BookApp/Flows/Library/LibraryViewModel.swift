import SwiftUI
import CloudKit
import Combine

class LibraryViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var books: [Book] = []
    @EnvironmentObject var userManager: UserManager
    
    private let bookService: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()

    
    
        
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
//                if books.isEmpty && self.books.isEmpty {
//                    self.returnEmpty = true
//                } else {
//                    self.books = self.books + sortBooks(books: books)
//                    self.currentPag += 20
//                }
//                self.currentState = .alreadyLoaded
                self.books.append(book)
            })
            .store(in: &subscriptions)
            
                
        }
    }
    
}
