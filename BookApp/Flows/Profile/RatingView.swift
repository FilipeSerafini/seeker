import SwiftUI

struct RatingView: View {
    var review: RateReview
    @EnvironmentObject var ratingViewModel: RatingViewModel
    
    var body: some View {
        NavigationLink(destination: BookView(book: ratingViewModel.userRatingBooks.first(where: { $0.id == review.bookID}) ?? Book()), label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("historicPost"))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(review.bookTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("historicTitle"))
                            .frame(width: 165, height: 25, alignment: .leading)
                        HStack {
                            ForEach(1...review.rate, id: \.self) { index in
                                Image("star.fill")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                            }
                        }
                    }
                    .padding(.all, 4)
                    .frame(width: 165, height: 60, alignment: .topLeading)
                }
                .frame(width: 175, height: 70)
            }
        })
        .disabled(!ratingViewModel.userRatingBooks.contains(where: { $0.id == review.bookID}))
    }
}
