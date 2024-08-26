//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 23.08.2024.
//

import Foundation

final class NetworkManager: ObservableObject {

    func fetcToDo(completion: @escaping (Result<[ToDo], Error>) -> Void) {
        DispatchQueue.main.async {
            
            let fetchRequest = URLRequest(url: Link.todo.url)
            URLSession.shared.dataTask(with: fetchRequest) {(data, response, error) -> Void in
                if let error = error {
                    completion(.failure(error))
                    print(error)
                } else {
                    let hhtpResponse = response as? HTTPURLResponse
                    print("status code \(hhtpResponse?.statusCode)")
                    
                    guard let safeData = data else {
                        if let error = error {
                            completion(.failure(error))
                        }
                        return
                    }
                    if let decodeQuery = try? JSONDecoder().decode(Query.self, from: safeData) {
                        let toDos = decodeQuery.todos
                        completion(.success(toDos))
                    }
                }
                
            }.resume()
        }
    }
    
}
