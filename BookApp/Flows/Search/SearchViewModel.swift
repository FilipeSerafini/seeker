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
    private var currentFilter: Filter = .empty
    @Published var returnEmpty: Bool = false
    @Published var isSearching: Bool = false
    
    func fetchBooks(searchedText: String, filter: Filter) {
        isSearching = true
        if currentState == .isLoading {
            return
        }
        
        if searchedText != currentSearch || currentFilter != filter {
            currentSearch = searchedText
            currentFilter = filter
            currentPag = 0
            books = []
            returnEmpty = false
        }
        
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
                if books.isEmpty && self.books.isEmpty {
                    self.returnEmpty = true
                } else {
                    self.books = self.books + sortBooks(books: books)
                    self.currentPag += 20
                }
                self.currentState = .alreadyLoaded
            })
            .store(in: &subscriptions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSearching = false
        }
    }
}
