//
//  CSDS395App.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI

@main
struct CSDS395App: App {
    @StateObject private var userController = UserController()

    var body: some Scene {
        WindowGroup {
//         HomeView(controller: AppController())
         IsLoginView().environment(\.managedObjectContext, userController.container.viewContext)
        }
    }
}

struct Previews_CSDS395App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
