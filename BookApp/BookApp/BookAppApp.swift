//
//  BookAppApp.swift
//  BookApp
//
//  Created by Filipe Serafini on 25/07/23.
//

import SwiftUI

@main
struct BookAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
