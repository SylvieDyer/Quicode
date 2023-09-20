//
//  CSDS395App.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI
import UIKit

@main
struct CSDS395App: App {
    // for core data
    let userDataController = UserDataController.shared


    var body: some Scene {
        WindowGroup {
            // for testing Drag and Drop
//            DragAndDropView(DNDCLASS: AppController.DND())
           
            MainView(appController: AppController())
                .environment(\.managedObjectContext, userDataController.container.viewContext)
        
            
//         HomeView(controller: AppController())
//         IsLoginView().environment(\.managedObjectContext, userController.container.viewContext)
        }
    }
}
