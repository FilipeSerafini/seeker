//
//  RatingButton.swift
//  BookApp
//
//  Created by Sabrina Souza on 08/08/23.
//

import SwiftUI

struct RatingButton: View {
    @State private var activeButton: Int? = nil
    @State var rating: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        self.activeButton = self.toggleActiveButton(index)
                        rating = index
                        if self.isActive(index) {
                            rating = index
                        } else {
                            rating = rating - 1
                        }
                        print("avaliacao: \(rating)")
                        
                    }) {
                        Image("star")
                            .resizable()
                            .frame(width: 31, height: 29)
                            .background(self.isActive(index) ? Image("star.fill")
                                .resizable()
                                .frame(width: 31, height: 29)
                                        : Image("star")
                                .resizable()
                                .frame(width: 31, height: 29)
                            )
                    }
                }
            }
            Text("Minha avaliação")
                .font(.system(size: 13))
        }
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
struct RatingButton_Previews: PreviewProvider {
    static var previews: some View {
        RatingButton()
    }
}
