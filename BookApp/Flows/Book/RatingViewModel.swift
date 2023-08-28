import Foundation
import SwiftUI
import CloudKit
import Combine

class RatingViewModel: ObservableObject {
    @Published var book: Book = Book()
    @Published var bookRate: Int = 0
    @Published var userID: String = ""
    @Published var userRateReviews: [RateReview] = []
    @Published var currentReview: Int = 0
    @Published var requestAlreadyMade: Bool = false
    @Published var userRatingBooks: [Book] = []
    private let bookService: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchRateReviews() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                self.fetchRateReviewsWith(recordID: recordID)
            case .failure(let failure):
                print("error trying to fetch userId: ",failure.localizedDescription)
            }
        }
    }
    
    private func fetchRateReviewsWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "RateReview"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[RateReview], Error>) in
            switch result {
            case .success(let userRateReviews):
                DispatchQueue.main.async {
                    self.requestAlreadyMade = true
                    self.userRateReviews = userRateReviews
                    self.fetchBooks()
                    self.fetchRateReviewsSemaphore.signal()
                }
            case .failure(let failure):
                self.fetchRateReviewsSemaphore.signal()
                print("error trying to fetch RatingReview: ",failure.localizedDescription)
            }
        }
    }
    
    private let fetchRateReviewsSemaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
    
    func getBookRate(bookID: String) {
        self.currentReview = self.userRateReviews.first(where: { $0.bookID == bookID })?.rate ?? 0
    }
    
    func addOrUpdateRateReview(book: Book) {
        if userRateReviews.contains(where: { $0.bookID == book.id }) {
            var rateReviewToUpdate = userRateReviews.first(where: { $0.bookID == book.id})!
            userRateReviews.removeAll(where: { $0.bookID == book.id})
            
            if currentReview != 0 {
                rateReviewToUpdate.record["rate"] = self.currentReview
                rateReviewToUpdate.rate = self.currentReview
                userRateReviews.append(rateReviewToUpdate)
                self.addRateReviewToCk(rateReview: rateReviewToUpdate)
            } else {
                self.deleteRateReviewFromCk(rateReview: rateReviewToUpdate)
            }
        } else {
            fetchBook(bookId: book.id)
            guard let newRateReview = RateReview(rate: self.currentReview, bookID: book.id, bookTitle: book.title) else { return }
            userRateReviews.append(newRateReview)
            self.addRateReviewToCk(rateReview: newRateReview)
        }
    }
    
    private func addRateReviewToCk(rateReview: RateReview) {
        CloudKitUtility.add(item: rateReview) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteRateReviewFromCk(rateReview: RateReview) {
        CloudKitUtility.delete(item: rateReview)
    }
    
    private func fetchBooks() {
        for userRateReview in userRateReviews {
            if userRateReview.rate == 0 {
                print("deletando rate review == 0")
                self.deleteRateReviewFromCk(rateReview: userRateReview)
            }
            
            if userRateReview.bookID != " " {
                bookService.fetchBookById(bookId: userRateReview.bookID)
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
                        self.userRatingBooks.append(book)
                    })
                    .store(in: &subscriptions)
            } else {
                print("BookId é vazio")
            }
        }
    }
    
    private func fetchBook(bookId: String) {
        bookService.fetchBookById(bookId: bookId)
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
                self.userRatingBooks.append(book)
            })
            .store(in: &subscriptions)
    }
}
