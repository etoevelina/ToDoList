//
//  DetailView.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 26.08.2024.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State var item: Item
    @State private var isEdited = false
    @State private var name: String
    @State private var description: String
    @State private var completed: Bool
    @ObservedObject var vm = CoreDataViewModel()

    
    init(item: Item) {
        self._item = State(initialValue: item)
        self._name = State(initialValue: item.toDoName ?? "")
        self._description = State(initialValue: item.toDoDescription ?? "")
        self._completed = State(initialValue: item.status)
       }


    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 23) {
                VStack(alignment: .leading, spacing: 11) {
                    Text("Title")
                        .font(.system(size: 23, weight: .bold))
                    TextEditor(text: $name)
                        .frame(width: 350, height: 44)
                        .background(Color(.white))
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: -1)
                                .stroke(Color(red: 0, green: 0.31, blue: 1), lineWidth: 2)
                        )
                }
                Toggle(isOn: $completed) {
                    Text("Completed")
                        .font(.system(size: 23, weight: .bold))
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(red: 0, green: 0.31, blue: 1)))
                .padding(.horizontal, 10)
                
                Spacer()
            }
            .padding()
        .navigationTitle("Detail View")
        .toolbar {
                Button {
                    vm.newData(item: item, viewContext: viewContext, name: name, description: description, completed: completed, dismiss: dismiss)
                } label: {
                    Text("Save")
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                    hideKeyboard()
                }
        }
        .background(Color(red: 0.9, green: 0.98, blue: 0.96))
        .alert(isPresented: $vm.showAlert, content: {
            Alert(title: Text("Ops"), message: Text(vm.alertMessage), dismissButton: .cancel())
        })
    }
}
