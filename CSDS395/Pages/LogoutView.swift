//
//  LogoutView.swift
//  CSDS395
//
//  Created by Helio Dong on 11/7/23.
//

import SwiftUI

import CoreData

struct LogoutView: View {
    var controller: AppController
    var viewContext: NSManagedObjectContext
    var user : User
    
    // the user info
    @FetchRequest(
        sortDescriptors: []
    )
    private var users: FetchedResults<User>
    
//    @State private var loadedModules = false
    @State private var isAuthenticated = false

    
    var body: some View {
        
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new -- ask to log in
        if !isAuthenticated {
            
            LoginView(appController: controller, viewContext: viewContext, authenticationSuccess: {
                self.isAuthenticated = true
            })
        }
        else {
            HomeView(controller: controller, viewContext: viewContext, user: users.first!)
            //TODO: commeneted out to so we don't have an AWS Issue, also we don't need to reload data here
//            if (!loadedModules){
//                var awsManager : AWSManager = AWSManager()
//                VStack {
//                    Text("QUICk! are you ready to CODE?!?!?!")
//                        .font(.title)
//                        .padding(50).fontWeight(.bold)
//                    HStack{
//                        Image(systemName: "balloon.2.fill")
//                        Image(systemName: "party.popper.fill")
//                        Image(systemName: "balloon")
//                        Image(systemName: "party.popper.fill")
//                        Image(systemName: "balloon.fill")
//                        Image(systemName: "balloon")
//                        Image(systemName: "party.popper.fill")
//                    }
//                    Button("Let's Go!",
//                           action: {getAWSData()}
//                    ).padding(50).foregroundColor(.purple).font(.title2).fontWeight(.bold)
//                }
//
//            } else { // otherwise, load Home!
//                HomeView(controller: controller, viewContext: viewContext, user: users.first!)
//            }
        }
    }
    
//    func getAWSData(){
//        Task{
//            do {
//                print("button hit")
//                await controller.setAppInfo(awsManager: awsManager)
//                loadedModules.toggle()
//            }
//        }
//    }
}

