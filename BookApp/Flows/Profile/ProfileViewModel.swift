import Foundation
import CloudKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var allCommentReviews: [CommentReview] = []
    
    func fetchCommentReview() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                print("aa", recordID)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func addCommentReview(comment: CommentReview) {
        print("adicionando comentario: ", comment.bookTitle)
        allCommentReviews.append(comment)
        
//        CloudKitUtility.add(item: comment) { result in
//            switch result {
//            case .success(_):
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
