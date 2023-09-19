//
//  MainView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/19/23.
//

import SwiftUI

// entry point view for application
struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var appController: AppController
    
    // the user info
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
    
    
    var body: some View {
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new
        if (users.isEmpty || users.first!.newUser){
            LoginView(appController: appController, viewContext: viewContext)
        }
        // otherwise, check that they are not new
        else if (users.first!.newUser == false){
            HomeView(controller: appController,  viewContext: viewContext, user: users.first!)
        }
            
    }
}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
