//
//  ViewModel.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 29.08.2024.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    func saveToCoreData(todo: ToDo, viewContext: NSManagedObjectContext) {
        let newItem = Item(context: viewContext)
        newItem.toDoDescription = todo.todo
        newItem.status = todo.completed
        newItem.timestamp = Date()
        
        do {
            try viewContext.save()
            UserDefaults.standard.setValue(false, forKey: "getData")
        } catch {
            print("Failed to save data to Core Data: \(error.localizedDescription)")
        }
    }
    
    func deleteItem(_ item: Item, viewContext: NSManagedObjectContext) {
        withAnimation {
            viewContext.delete(item)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func newData(item: Item, viewContext: NSManagedObjectContext, name: String, description: String, completed: Bool, dismiss: DismissAction) {
        let id = item.objectID
        
        do {
            if let todo = try viewContext.existingObject(with: id) as? Item {
                todo.toDoName = name
                todo.toDoDescription = description
                todo.status = completed
                try viewContext.save()
                dismiss()

            }
        } catch let error {
            print(error)
            showAlert = true
            alertMessage = "\(error.localizedDescription)"
            
        }
    }
    
    func addItem(viewContext: NSManagedObjectContext, title: String, description: String, dismiss: DismissAction) {
        withAnimation {
            if title.isEmpty {
                showAlert = true
                alertMessage = "The title couldn't be empty"
                return
            }

            let newItem = Item(context: viewContext)
            newItem.toDoName = title
            newItem.toDoDescription = description
            newItem.status = false
            newItem.timestamp = Date()

            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
