//
//  RecommendedView.swift
//  BookApp
//
//  Created by Waldyr Schneider on 02/08/23.
//
import SwiftUI
import Foundation

struct RecommendedView: View {
    
    @EnvironmentObject private var recommendedViewModel: RecommendedViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Text("Fiction books")
                        .font(.system(size: 17, weight: .semibold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(recommendedViewModel.firstList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(.bottom)
            
            VStack{
                HStack {
                    Text("Romance books")
                        .font(.system(size: 17, weight: .semibold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(recommendedViewModel.secondList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading){
                HStack {
                    Text("Education books")
                        .font(.system(size: 17, weight: .semibold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(recommendedViewModel.thirdList) { book in
                            BookResearchedCover(book: book)
                        }
                        .padding(.leading)
                    }
                }
                
            }
        }.onAppear(perform: {
            recommendedViewModel.fetchBooksFirst(searchedGenre: "fiction", filter: .genre)
            recommendedViewModel.fetchBooksSecond(searchedGenre: "romance", filter: .genre)
            recommendedViewModel.fetchBooksThird(searchedGenre: "education", filter: .genre)
        })
    }
}
