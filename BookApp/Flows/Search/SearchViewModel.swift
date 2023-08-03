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
            .mapAPIBookToBook()
            .setBookImages(withService: self.service)
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
