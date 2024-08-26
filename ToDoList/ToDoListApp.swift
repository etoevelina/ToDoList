//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 23.08.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
