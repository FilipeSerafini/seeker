//
//  RatingButtonViewModel.swift
//  BookApp
//
//  Created by Filipe Serafini on 10/08/23.
//

import Foundation
import SwiftUI
import CloudKit

class RatingViewModel: ObservableObject {
    
    @Published var book: Book = Book()
    @Published var bookRate: Int = 0
    @Published var userID: String = ""
    
    @Published var userRateReviews: [RateReview] = []
    
    @Published var currentReview: Int = 0
    
    
    @EnvironmentObject var userManager: UserManager
    
    
    func fetchRateReviews() {
        CloudKitUtility.fetchUserRecordID { (result: Result<CKRecord.ID, Error>) in
            switch result {
            case .success(let recordID):
                
                self.fetchRateReviewsWith(recordID: recordID)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchRateReviewsWith(recordID: CKRecord.ID) {
        let reference = CKRecord.Reference(recordID: recordID, action: .none)
        let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
        let recordType = "RateReview"
        
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType) { (result: Result<[RateReview], Error>) in
            switch result {
            case .success(let userRateReviews):
                DispatchQueue.main.async {
                    self.userRateReviews = userRateReviews
                    //                    print(self.rateReviews)
                    //AQUI TENHO AS RATE REVIEWS
                    print("Chegou")
                    
                    self.fetchRateReviewsSemaphore.signal()
                    
                }
            case .failure(let failure):
                self.fetchRateReviewsSemaphore.signal()
                
                print(failure.localizedDescription)
            }
        }
    }
    
    
    private let fetchRateReviewsSemaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
    private let thread = DispatchQueue(label: "fetchRate", qos: .background)
    
    func getBookRate(bookID: String) {
        
        thread.async {
            self.fetchRateReviews()
            print("Esperou")
            self.fetchRateReviewsSemaphore.wait()
            print("Recebeu")
            let rateReview = self.userRateReviews.first { rate in
                rate.bookID == bookID
            }
            DispatchQueue.main.async {
                self.currentReview = rateReview?.rate ?? 0
                
            }
        }
    }
    
    //    func getBookRate(bookID: String, completion: @escaping ((Result<Int, Error>) -> Void)) {
    //        fetchRateReviews()
    //        fetchRateReviewsSemaphore.wait()
    //
    //        let result: Int
    //        if let rateReview = self.rateReviews.first(where: { $0.bookID == bookID }) {
    //            result = rateReview.rate
    //        } else {
    //            result = 0
    //        }
    //
    //        completion(.success(result))
    //    }
    
    
    
    
    func addOrUpdateRateReview(rate: Int, book: Book) {
        if !userRateReviews.isEmpty {
            if userRateReviews.contains(where: { $0.bookID == book.id }) {
                let rateReviewToUpdate = userRateReviews.first(where: { $0.bookID == book.id})!
                
                rateReviewToUpdate.record["rate"] = rate
                
                CloudKitUtility.update(item: rateReviewToUpdate) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
                self.fetchRateReviews()
                print("deu update")
            }
            else {
                
                guard let newRateReview = RateReview(rate: rate, bookID: book.id) else { return }
                
                addBookToCK(rateReview: newRateReview)
                self.fetchRateReviews()
                print("criou no if")
            }
        }
        else {
            
            guard let newRateReview = RateReview(rate: rate, bookID: book.id) else { return }
            
            addBookToCK(rateReview: newRateReview)
            self.fetchRateReviews()
            print("criou no else")
        }
        
//        if !userRateReviews.isEmpty {
//
//            self.userRateReviews.forEach { rateReview in
//                if rateReview.bookID == book.id {
//                    alreadyHasRate = true
//                    let rateReviewToUpdate = rateReview
//
//                    rateReviewToUpdate.record["rate"] = rate
//
//                    CloudKitUtility.update(item: rateReviewToUpdate) { result in
//                        switch result {
//                        case .success(_):
//                            break
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//
//                    self.fetchRateReviews()
//                    print("deu update")
//                }
//                else {
//
//                    guard let newRateReview = RateReview(rate: rate, bookID: book.id) else { return }
//
//                    addBookToCK(rateReview: newRateReview)
//                    self.fetchRateReviews()
//                    print("criou no if")
//                }
//            }
//        } else {
//
//            guard let newRateReview = RateReview(rate: rate, bookID: book.id) else { return }
//
//            addBookToCK(rateReview: newRateReview)
//            self.fetchRateReviews()
//            print("criou no else")
//        }
    }
    
    func addBookToCK(rateReview: RateReview) {
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
