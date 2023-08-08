//
//  LoadingOracle.swift
//  BookApp
//
//  Created by Sabrina Souza on 07/08/23.
//

import SwiftUI

struct LoadingOracle: View {
    @State private var isAnimated = true
    var body: some View {
        HStack{
            Text("Zoe está digitando")
                .font(.system(size: 15, design: .serif))
                .foregroundColor(.gray)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 5, height: 5)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: isAnimated)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 5, height: 5)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: isAnimated)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 5, height: 5)
                .scaleEffect(isAnimated ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: isAnimated)
        }
        .onAppear{
            self.isAnimated = false
        }
    }
}

struct LoadingOracle_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOracle()
    }
}
