//
//  TabViewApp.swift
//  BookApp
//
//  Created by Maria Luísa Lamb Souto on 27/07/23.
//

import SwiftUI

struct TabViewApp: View {
    
    @State private var selectedTab = 0

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes =
               [.font: UIFont(descriptor:
                       UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                       .withDesign(.serif)!, size: 34)]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
        
        TabView(selection: $selectedTab) {
            LibraryView()
                .tabItem {
                selectedTab == 0 ? Image("libraryIconSelected") : Image(systemName: "books.vertical")
                Text("Library")
            }
            .tag(0)
            
            SearchView()
            .tabItem {
                selectedTab == 1 ? Image("searchIconSelected") : Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            
            OracleView()
            .tabItem {
                selectedTab == 2 ? Image("oracleIconSelected") : Image("oracleIcon")
                Text("Oracle")
            }
            .tag(2)
            
            ChallengesView()
            .tabItem {
                selectedTab == 3 ? Image("challengeIconSelected") : Image(systemName: "rosette")
                Text("Challenges")
            }
            .tag(3)
            
            ProfileView()
            .tabItem {
                selectedTab == 4 ? Image("perfilIconSelected") : Image(systemName: "person")
                Text("Perfil")
            }
            .tag(4)
        }
        .tint(Color(red: 0.514, green: 0.574, blue: 0.856))
    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
