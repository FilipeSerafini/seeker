import Foundation
import CloudKit
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var allCommentReviews: [CommentReview] = []
    
    func fetchCommentReview() {
        print("pegando reviews do usuario...")
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                let reference = CKRecord.Reference(recordID: recordID, action: .none)
                let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
                let recordType = "CommentReview"
                
                CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[CommentReview], Error>) in
                    switch result {
                    case .success(let userCommentReviews):
                        print("sucesso em pegar as reviews do usuario")
                        DispatchQueue.main.async {
                            self.verifyNewComment(newComments: userCommentReviews)
//                            self.allCommentReviews = userCommentReviews
                        }
                    case .failure(let failure):
                        print("erro ao pegar reviews do banco")
                        print(failure.localizedDescription)
                    }
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func verifyNewComment(newComments: [CommentReview]) {
        for newComment in newComments {
            if !allCommentReviews.contains(where: { $0.id == newComment.id }) {
                allCommentReviews.append(newComment)
            }
        }
    }
    
    func addCommentReview(comment: CommentReview) {
        print("adicionando comentario: ", comment.bookTitle)
        allCommentReviews.append(comment)
        
        CloudKitUtility.add(item: comment) { result in
            switch result {
            case .success(_):
                print("salvo no cloud kit com sucesso!")
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
