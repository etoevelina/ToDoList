//
//  ContentView.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 23.08.2024.
//
import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)], animation: .none)
    private var items: FetchedResults<Item>
    
    @AppStorage("getData") var getData = true
    @StateObject var networkManager = NetworkManager()
    @ObservedObject var vm = CoreDataViewModel()
    @State private var isEditing = false
    @State private var shouldShowAddView = false
    @State private var toDo = [ToDo]()
    @State private var showAlert = false
    @State private var alertMessage = ""
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        ZStack {
                            NavigationLink {
                                DetailView(item: item)
                            }label: {
                                ToDoItemVIew(item: item, title: item.toDoName ?? "", descrition: item.toDoDescription ?? "", timestamp: item.timestamp ?? Date(), status: item.status)  
                            }
                            if isEditing {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            vm.deleteItem(item, viewContext: viewContext)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.red)
                                        }
                                        .transition(.scale)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .animation(.easeInOut, value: isEditing)
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Ops"), message: Text(alertMessage), dismissButton: .cancel())
                        })
                    }
                    
                }
            }
            .background(Color(red: 0.9, green: 0.98, blue: 0.96))
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isEditing {
                        Button {
                            withAnimation {
                                isEditing.toggle()
                            }
                        } label: {
                            Text("Edit")
                        }
                    } else {
                        Button {
                            withAnimation {
                                isEditing.toggle()
                            }
                        } label: {
                            Text("Done")
                        }
                    }
                }
                ToolbarItem {
                    Button{
                        shouldShowAddView = true
                    } label: {
                        Image(systemName:  "plus")
                    }
                }
            }
            .onAppear() {
                if getData {
                    networkManager.fetcToDo { result in
                        switch result {
                        case .success(let toDos):
                            for todo in toDos {
                                vm.saveToCoreData(todo: todo, viewContext: viewContext)
                            }
                        case .failure(let error):
                            print(error)
                            showAlert = true
                            alertMessage = "\(error.localizedDescription)"
                            
                        }
                    }
                    
                }
            }
        }

        
        .sheet(isPresented: $shouldShowAddView) {
            AddNewToDoView()
                .presentationDetents([.medium])
        }
    }
    
    

}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
