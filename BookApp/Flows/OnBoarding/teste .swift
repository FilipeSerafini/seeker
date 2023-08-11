//
//  teste .swift
//  BookApp
//
//  Created by Maria Luísa Lamb Souto on 11/08/23.
//

import SwiftUI

struct teste_: View {
    var body: some View {
            VStack{
                
                VStack{
                    Text("teste")
                        .font(.system(size: 17, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                NavigationLink {
                    TabViewApp()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color("primary"))
                            .cornerRadius(22)
                            .frame(width: 125, height: 39)
                        Text("Começar")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                    }
                }

            
        }
    }
}

struct teste__Previews: PreviewProvider {
    static var previews: some View {
        teste_()
    }
}
