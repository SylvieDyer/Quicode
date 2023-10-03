//
//  AppDelegation.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/18/23.
//

import Foundation
import CoreData
import UIKit

class AppDelegate : UIResponder, UIApplicationDelegate{
    var persistentContainer: NSPersistentContainer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        persistentContainer = NSPersistentContainer(name: "AppDataModel")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return true
    }

}

