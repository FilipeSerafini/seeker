import SwiftUI

struct RatingButton: View {
    @State private var activeButton: Int? = nil
    @State private var currentReviewRate: Int = 0
    @Binding var book: Book
    @Binding var rating: Int
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
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
                currentReviewRate = self.ratingViewModel.currentReview
            }
        })
        .onDisappear(perform: {
            if self.ratingViewModel.currentReview != 0 || self.ratingViewModel.userRateReviews.contains(where: { $0.bookID == book.id}) {
                if self.ratingViewModel.currentReview != currentReviewRate {
                    self.ratingViewModel.addOrUpdateRateReview(book: self.book)
                }
            }
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
