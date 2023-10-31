//
//  LogoutView.swift
//  CSDS395
//
//  Created by Helio Dong on 10/9/23.
//

import SwiftUI
import CoreData

// entry-point view for application
struct LogoutView: View {
    var viewContext: NSManagedObjectContext
    var appController: AppController
    
    // the user info
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
    
    
    var body: some View {
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new
        if (users.first!.isLoggedOut || users.first!.newUser){
            LoginView(appController: appController, viewContext: viewContext)
        }
        // otherwise, check that they are not new
        else if (users.first!.newUser == false){
            HomeView(controller: appController, viewContext: viewContext, user: users.first!)
        }
    }
}
