//
//  BookView.swift
//  BookApp
//
//  Created by Maria Luísa Lamb Souto on 27/07/23.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray)
                    .padding(.top, 300)
                    .ignoresSafeArea()

                VStack{
                    ZStack {
                        Image("bookImage")
                            .resizable()
                            .frame(width: 170, height: 245)
                            .cornerRadius(15)
                        ZStack{
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 50, height: 50)
                            Text("4,5")
                        }
                        .padding(.leading, 160)
                        .padding(.top, -150)
                    }
                    .padding(.top, 60)
                    VStack {
                        Text ("BOOK AUTHOR")
                            .font(.system(size: 17, weight: .regular))
                            .padding(.bottom, 2)
                            .padding(.top, 2)
                        Text ("Book Title")
                            .font(.system(size: 34, weight: .medium, design: .serif))
                            .padding(.bottom, 5)
                            .padding(.top, 2)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.red)
                            .frame(width: 358, height: 64)
                        
                        ScrollView{
                            Text ("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                .font(.system(size: 17, weight: .regular))

                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
