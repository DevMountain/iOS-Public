//
//  Task + Convenience.swift
//  Task
//
//  Created by Frank Martin Jr on 2/12/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init?(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
}
