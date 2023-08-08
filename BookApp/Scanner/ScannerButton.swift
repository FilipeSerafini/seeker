//
//  button.swift
//  BookApp
//
//  Created by Sabrina Souza on 08/08/23.
//

import SwiftUI

struct ScannerButton: View {
    @State var isPresented = false
    @Binding var foundBook: Book?  
    
    var body: some View {
        VStack {
            Button(action: {
                self.isPresented.toggle()
            }) {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .frame(width: 28, height: 22)
            }.sheet(isPresented: $isPresented) {
                BarCodeScanner(foundBook: $foundBook)
            }
        }
    }
}
