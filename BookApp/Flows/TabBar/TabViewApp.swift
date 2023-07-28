//
//  TabViewApp.swift
//  BookApp
//
//  Created by Maria Luísa Lamb Souto on 27/07/23.
//

import SwiftUI

struct TabViewApp: View {
    
    init() {
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 34)!]
        }
    
    /* para colocar imagem no background da tab
     
    init() {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundImage = UIImage(named: "")
           UITabBar.appearance().scrollEdgeAppearance = appearance
       }
     
     */
    var body: some View {
        
        HStack{
            TabView {
                LibraryView()
                    .tabItem {
                        Label("", systemImage: "books.vertical")
                    }
                SearchView()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }
                OracleView()
                    .tabItem {
                        Label("", systemImage: "scribble.variable")
                    }
                ChallengesView()
                    .tabItem {
                        Label("", systemImage: "circlebadge.2")
                    }
                ProfileView()
                    .tabItem {
                        Label("", systemImage: "person")
                    }
            }
            .accentColor(.purple)
        }
    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
