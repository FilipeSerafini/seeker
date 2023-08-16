import Foundation
import SwiftUI
import CloudKit

class RatingViewModel: ObservableObject {
    
    @Published var book: Book = Book()
    @Published var bookRate: Int = 0
    @Published var userID: String = ""
    @Published var userRateReviews: [RateReview] = []
    @Published var currentReview: Int = 0
    @Published var requestAlreadyMade: Bool = false
    @EnvironmentObject var userManager: UserManager
    
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
                    self.fetchRateReviewsSemaphore.signal()
                }
            case .failure(let failure):
                self.fetchRateReviewsSemaphore.signal()
                print("error trying to fetch RatingReview: ",failure.localizedDescription)
            }
        }
    }
    
    
    private let fetchRateReviewsSemaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
    private let thread = DispatchQueue(label: "fetchRate", qos: .background)
    
    func getBookRate(bookID: String) {
        thread.async {
            self.fetchRateReviews()
            self.fetchRateReviewsSemaphore.wait()
            let rateReview = self.userRateReviews.first { rate in
                rate.bookID == bookID
            }
            DispatchQueue.main.async {
                self.currentReview = rateReview?.rate ?? 0
            }
        }
    }
    
    func addOrUpdateRateReview(rate: Int, book: Book) {
        if userRateReviews.contains(where: { $0.bookID == book.id }) {
            var rateReviewToUpdate = userRateReviews.first(where: { $0.bookID == book.id})!
            
            rateReviewToUpdate.record["rate"] = rate
            rateReviewToUpdate.rate = rate
            
            userRateReviews.removeAll(where: { $0.bookID == book.id})
            userRateReviews.append(rateReviewToUpdate)
            
            CloudKitUtility.update(item: rateReviewToUpdate) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print("error trying to update RatingReview: ",error.localizedDescription)
                }
            }
        } else {
            guard let newRateReview = RateReview(rate: rate, bookID: book.id, bookTitle: book.title) else { return }
            userRateReviews.append(newRateReview)
            addBookToCK(rateReview: newRateReview)
        }
    }
    
    private func addBookToCK(rateReview: RateReview) {
        CloudKitUtility.add(item: rateReview) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
