//
//  RatingButton.swift
//  BookApp
//
//  Created by Sabrina Souza on 08/08/23.
//

import SwiftUI

struct RatingButton: View {
    @State private var activeButton: Int? = nil
    
    @Binding var book: Book
    @Binding var rating: Int
    
    @StateObject var ratingViewModel: RatingViewModel
    
    var body: some View {
        VStack {
            HStack {
                
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        self.activeButton = self.toggleActiveButton(index)
                        self.ratingViewModel.currentReview = index
                        if self.isActive(index) {
                            self.ratingViewModel.currentReview = index
                        } else {
                            self.ratingViewModel.currentReview = self.ratingViewModel.currentReview - 1
                        }
                        print("avaliacao: \(self.ratingViewModel.currentReview)")
                        
                    }) {
                        Image("star")
                            .resizable()
                            .frame(width: 31, height: 29)
                            .background(self.ratingViewModel.currentReview >= index ?
                                        Image("star.fill")
                                            .resizable()
                                            .frame(width: 31, height: 29) :
                                        Image("star")
                                            .resizable()
                                            .frame(width: 31, height: 29)
                            )
                    }
                }
            }
            Text("Minha avaliação")
                .font(.system(size: 13))
        }
        .onAppear(perform: {
            Task {
               self.ratingViewModel.getBookRate(bookID: book.id)
            }
        })
        .onDisappear(perform: {
            
            if self.ratingViewModel.currentReview != 0 {
                self.ratingViewModel.addOrUpdateRateReview(rate: self.ratingViewModel.currentReview, book: self.book)
                
                
            } else {
                print("avaliacao 0 ent n criei")
            }
//            self.ratingViewModel.deleteAllRateReviews()
        })
    }
    
    func isActive(_ index: Int) -> Bool {
        if let active = activeButton {
            return index <= active
        }
        return false
    }
    
    func toggleActiveButton(_ index: Int) -> Int? {
        if let active = activeButton, active == index {
            let activeFinal = active - 1
            return activeFinal
        }
        return index
    }
}
//struct RatingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingButton()
//    }
//}
