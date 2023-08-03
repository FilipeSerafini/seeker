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
                    Text("Livros de Ficção")
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
                    Text("Livros de Romance")
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
                    Text("Mais de Rupi Kaur")
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
        }
    }
}
