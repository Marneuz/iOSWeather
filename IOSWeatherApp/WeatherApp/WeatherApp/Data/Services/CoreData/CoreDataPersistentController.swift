//
//  CoreDataPersistentController.swift
//  WeatherApp
//
//  Created by user241563 on 24/11/23.
//

import Foundation
import CoreData

struct CoreDataPersistentController {
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "Main")
        container.loadPersistentStores { description, error in
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            
            print(paths)
            
            if let error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
