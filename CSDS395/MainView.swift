//
//  MainView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/19/23.
//

import SwiftUI

// entry-point view for application
struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var appController: AppController
    
    // the user info
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
    
    /// SOLEY FOR TESTING PURPOSES ( content previewing)
    //    var isTestingSinglePage: Bool
    
    var body: some View {
        
        /// THIS IS THE  FINAL CODE:
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new
        if (users.isEmpty || users.first!.newUser){
            LoginView(appController: appController, viewContext: viewContext)
        }
        // otherwise, check that they are not new
        else if (users.first!.newUser == false){
//            HomeView(controller: appController, user: users.first!)
            LoginView(appController: appController, viewContext: viewContext)
        }
    }
}
    
/// to make fake user?
//    func fakeUser() -> User{
//        let newUser = User()
//        newUser.firstName = "FIRST NAME"
//        newUser.lastName = "LAST NAME"
//        newUser.email = "EMAIL"
//        newUser.id = UUID()
//        newUser.newUser = false
//        return newUser
//    }
//}

    
    
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
