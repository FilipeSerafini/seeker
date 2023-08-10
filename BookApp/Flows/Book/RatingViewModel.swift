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
    
    
    
    func addRateReview(rate: Int, book: Book) {
        guard let rateReview = RateReview(rate: rate, bookID: book.id) else { return }
        
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
