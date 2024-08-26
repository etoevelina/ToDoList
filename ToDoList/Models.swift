//
//  Models.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 23.08.2024.
//

import Foundation
import SwiftUI

struct ToDo: Decodable, Hashable {
    let todo: String
    let completed: Bool
}

struct Query: Decodable {
    let todos: [ToDo]
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

enum Link  {
    case todo
    
    var url: URL{
        switch self {
        case.todo:
            return URL(string:"https://dummyjson.com/todos")!
        }
    }
}

 let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
