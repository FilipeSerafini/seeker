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
        
        let defaults = UserDefaults.standard
        self.currentPag = defaults.integer(forKey: "currentPag")
        
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
                self.firstList = sortBooks(books: list1)
                self.secondList = sortBooks(books: list2)
                self.thirdList = sortBooks(books: list3)
                if self.currentPag > 60 {
                    defaults.set(0, forKey: "currentPag")
                } else {
                    defaults.set(self.currentPag + 20, forKey: "currentPag")
                }
            })
            .store(in: &subscriptions)
    }
}
