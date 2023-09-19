//
//  File.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/11/23.
//
import CoreData

class UserController : ObservableObject {
    let container = NSPersistentContainer(name: "User")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("User Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
