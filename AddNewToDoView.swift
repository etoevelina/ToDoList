//
//  AddNewToDoView.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 26.08.2024.
//

import SwiftUI

struct AddNewToDoView: View {
    @State var title = ""
    @State var description = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack{
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.68, green: 1, blue: 0.98), location: 0),
                    Gradient.Stop(color: Color(red: 0.58, green: 0.75, blue: 1), location: 1),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
            
            VStack (spacing: 23){
                
                HStack {
                    Text("New To-Do")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 11) {
                    Text("Title")
                        .font(.system(size: 23, weight: .bold))
                    TextField(" ", text: $title)
                        .frame(width: 350, height: 44)
                        .background(Color(.white))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: -1)
                                .stroke(Color(red: 0, green: 0.31, blue: 1), lineWidth: 2)
                        )
                }
                VStack(alignment: .leading, spacing: 11){
                    Text("Description")
                        .font(.system(size: 23, weight: .bold))
                    TextEditor(text: $description)
                        .frame(width: 350, height: 100)
                        .background(Color(.white))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: -1)
                                .stroke(Color(red: 0, green: 0.31, blue: 1), lineWidth: 2)
                        )   
                }
                
                Button {
                    addItem()
                } label: {
                    Text ("save")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color(red: 0, green: 0.31, blue: 1))
                        .cornerRadius(35)
                    
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Ops"), message: Text(alertMessage), dismissButton: .cancel())
        })
    }
    func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.toDoName = title
            newItem.toDoDescription = description
            newItem.status = false
            newItem.timestamp = Date()

            do {
                if !title.isEmpty {
                    try viewContext.save()
                    dismiss()
                } else {
                     showAlert = true
                     alertMessage = "The title could't be empty"
                }
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
