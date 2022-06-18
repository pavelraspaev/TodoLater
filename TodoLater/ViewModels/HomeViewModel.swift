//
//  ItemViewModel.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 31.05.2022.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    @Published var tasksCount: Double = 0
    @Published var tasksCompletedCount: Double = 0
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TaskCD")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA - \(error)")
            }
        }
        getTasks()
    }
    
    func getTasks() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        do {
            tasks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching - \(error)")
        }
    }
    
    func addTask(name: String, type: String, isCompleted: Bool) {
        let newTask = Task(context: container.viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.type = type
        newTask.isCompleted = isCompleted
        saveData()
    }
    
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let entity = tasks[index]
            container.viewContext.delete(entity)
            saveData()
        }
    }
    
    func completeTask(_ task: Task) {
        task.isCompleted.toggle()
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            getTasks()
        } catch let error {
            print("Error saving - \(error)")
        }
    }
}

