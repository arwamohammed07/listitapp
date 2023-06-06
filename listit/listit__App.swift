//
//  listit__App.swift
//  listit!!
//
//  Created by Arwamohammed07 on 08/08/1444 AH.
//

import SwiftUI

@main
struct listit__App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
