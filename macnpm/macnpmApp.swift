//
//  macnpmApp.swift
//  macnpm
//
//  Created by Foysal Ahamed on 15/01/2021.
//

import SwiftUI

@main
struct macnpmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
