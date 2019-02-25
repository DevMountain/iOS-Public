//
//  TaskController.swift
//  Task
//
//  Created by Frank Martin on 2/20/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // Shared instance
    static let shared = TaskController()
    
    // Source of truth
    var tasks: [Task] {
        
        // Create the fetch request
        let fetchRequest: NSFetchRequest<Task> = NSFetchRequest(entityName: "Task")
        do {
            // Return the results of the fetch request.
           return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("There was an error fetching the Tasks: \(error)")
            return []
        }
    }
    
    func createTaskWith(_ name: String, _ notes: String?, _ due: Date?) {
        
        // Initialize a new Task object
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(_ task: Task, _ name: String, notes: String?, due: Date?) {
        
        // Set the tasks's properties to the parameters that were passed in
        task.name = name
        task.notes = notes
        task.due = due
        
        saveToPersistentStore()
        
    }
    
    func delete(_ task: Task) {
        
        // Remove the task from the Managed Object Context
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving to the persistent store. \(error)")
        }
    }
    
}
