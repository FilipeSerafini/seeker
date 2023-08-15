import Foundation
import CloudKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var userCommentReviews: [CommentReview] = []
    @Published var requestAlreadyMade: Bool = false
    
    func fetchUserData() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                self.fetchUserCommentReview(recordID: recordID)
            case .failure(let failure):
                print("error trying to fetch userId: ", failure.localizedDescription)
            }
        }
    }
    
    private func fetchUserCommentReview(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "CommentReview"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[CommentReview], Error>) in
            switch result {
            case .success(let userCommentReviews):
                DispatchQueue.main.async {
                    self.requestAlreadyMade = true
                    self.userCommentReviews = userCommentReviews
                }
            case .failure(let failure):
                print("error trying to fetch CommentReview: ", failure.localizedDescription)
            }
        }
    }
    
    func saveUserCommentReview(comment: CommentReview) {
        userCommentReviews.append(comment)
        CloudKitUtility.add(item: comment) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print("error trying to save CommentReview: ", error.localizedDescription)
            }
        }
    }
}
