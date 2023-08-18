//
//  OpenComment.swift
//  Seeker
//
//  Created by Sabrina Souza on 18/08/23.
//

import SwiftUI

struct OpenComment: View {
    @State var comment: CommentReview

    @EnvironmentObject var profileViewModel: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Image("bookImage")
                            .resizable()
                            .frame(width: 62, height: 88)
                            .cornerRadius(10)
                            .shadow(color: Color("shadowBook"), radius: 4, x: 2, y: 4)
                    }
                    
                    VStack(alignment: .leading){
                        Text("")
                            .font(.system(size: 13))
                            .textCase(.uppercase)
                        Text(comment.bookTitle)
                            .font(.system(size: 22, weight: .medium, design: .serif))
                    }
                    .padding(.bottom, 30)
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
                Divider()
                    .padding(.horizontal)
                VStack{
                    Text(comment.comment)
                        .font(.system(size: 17))
                        .padding(.vertical)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(
                Image("backgroundImage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
            .background(Color("backgroundColor"))
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(comment.bookTitle)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                }
            }
        }
    }
}
