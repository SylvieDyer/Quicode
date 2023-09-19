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
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
           
            MainView(appController: AppController())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        
            
//         HomeView(controller: AppController())
//         IsLoginView().environment(\.managedObjectContext, userController.container.viewContext)
        }
    }
}

struct Previews_CSDS395App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
