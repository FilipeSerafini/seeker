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
                    .fill(.blue)
                    .padding(.top, 250)
                
                ZStack {
                    Image("pequeno")
                        .resizable()
                        .frame(width: 170, height: 245)
                        .cornerRadius(15)
                    ZStack{
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 50, height: 50)
                        Text("4,5")
                        
                    }
                    .padding(.bottom, 240)
                    .padding(.leading, 160)
                }
                .padding(.bottom, 200)
                VStack {
                    Text ("Antoine de Saint-Exupéry")
                    Text ("O Pequeno Príncipe")
                    Text ("Um piloto cai com seu avião no deserto e ali encontra uma criança loura e frágil. Ela diz ter vindo de um pequeno planeta distante. E ali, na convivência com o piloto perdido, os dois repensam os seus valores e encontram o sentido da vida.")

                }
                .padding(.top, 280)
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
