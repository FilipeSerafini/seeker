//
//  RatingView.swift
//  BookApp
//
//  Created by Waldyr Schneider on 16/08/23.
//

import SwiftUI

struct RatingView: View {
    
    var review: RateReview
    
    var body: some View {
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
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(review: RateReview(rate: 2, bookID: "123", bookTitle: "Jogos Vorazes")!)
    }
}
