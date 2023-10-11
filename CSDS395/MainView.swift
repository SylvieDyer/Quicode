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
    
    @State private var loadedModules = false
    var awsManager : AWSManager = AWSManager()
    
    /// SOLEY FOR TESTING PURPOSES ( content previewing)
    //    var isTestingSinglePage: Bool
    
    var body: some View {
        
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new -- ask to log in
        if (users.isEmpty || users.first!.newUser){
            LoginView(appController: appController, viewContext: viewContext)
        }
        // otherwise, check that they are not new (if they are, something went wrong
        else if (users.first!.newUser == false){
            // if need to load from S3, show popup
            if (!loadedModules){
                VStack {
                    Text("Are you ready to QUICODE?!")
                        .font(.title)
                        .padding(50).fontWeight(.bold)
                    HStack{
                        Image(systemName: "balloon.2.fill")
                        Image(systemName: "party.popper.fill")
                        Image(systemName: "balloon")
                        Image(systemName: "party.popper.fill")
                        Image(systemName: "balloon.fill")
                        Image(systemName: "balloon")
                        Image(systemName: "party.popper.fill")
                    }
                    Button("Let's Go!",
                           action: { getAWSData() }
                    ).padding(50).foregroundColor(.purple).font(.title2).fontWeight(.bold)
                }
                
            } else { // otherwise, load Home!
                HomeView(controller: appController, user: users.first!)
            }
        }
    }
    
    func getAWSData(){
        Task{
            do {
                print("button hit")
                await appController.setAppInfo(awsManager: awsManager)
                loadedModules.toggle()
            }
            
        }
    }
}
