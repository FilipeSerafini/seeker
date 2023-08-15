//import Foundation
//import SwiftUI
//import CloudKit
//import Combine
//
//class FolderViewModel: ObservableObject {
//    
//    var books: [Book] = []
//    @EnvironmentObject var userManager: UserManager
//    private let bookService: BookService = BookService()
//    private var subscriptions = Set<AnyCancellable>()
//
//    func fetchBooks(bookIDs: [String]) {
//        
//        bookIDs.forEach { bookID in
//            
//            bookService.fetchBookById(bookId: bookID)
//                .mapAPIBookToBook()
//                .setBookImages(withService: bookService)
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .failure(let error):
//                        print(error)
//                    case .finished:
//                        return
//                    }
//                }, receiveValue: { book in
//                    self.books.append(book)
//                })
//                .store(in: &subscriptions)
//        }
//    }
//}
