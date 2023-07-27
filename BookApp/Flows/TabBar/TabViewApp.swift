//
//  TabViewApp.swift
//  BookApp
//
//  Created by Maria Luísa Lamb Souto on 27/07/23.
//

import SwiftUI

struct TabViewApp: View {
    var body: some View {
        
        HStack{
            TabView {
                ProfileView()
                    .tabItem {
                        Label("", systemImage: "books.vertical")
                    }
            #warning("mudar para search")
                LibraryView()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }
                OracleView()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }
                ChallengesView()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }
                ProfileView()
                    .tabItem {
                        Label("", systemImage: "person")
                    }
            }
        }
    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
