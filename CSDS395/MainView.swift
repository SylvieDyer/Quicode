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
    var dbManager : DBManager = DBManager()
    
    var colorManager = ColorManager()
    
    /// SOLEY FOR TESTING PURPOSES ( content previewing)
    //    var isTestingSinglePage: Bool
    
    var body: some View {
        
        // because first should be for THIS user (won't store more than one):
        // if there are no users, or they're sill marked as new -- ask to log in
        if (appController.viewController.logInPage){
            // TODO: UNCOMMENT LATER
            //            || users.isEmpty || users.first!.newUser){
            LoginView(appController: appController, awsManager: awsManager, dbManager: dbManager, viewContext: viewContext, authenticationSuccess: {
                appController.viewController.setAsHome()
                print("IS HOME??")
                print(appController.viewController.homePage)
                print(appController.viewController.logInPage)
            })
        }
        else {
            if (users.first!.newUser == false){
                VStack {
                    // if need to load from S3, show popup
                    if (!loadedModules){
                        VStack {
                            Text("QUICk! are you ready to CODE?!?!?!")
                                .font(.title)
                                .padding(50).fontWeight(.bold).multilineTextAlignment(.center)
                            HStack{
                                Image(systemName: "balloon.2.fill")
                                Image(systemName: "party.popper.fill")
                                Image(systemName: "balloon")
                                Image(systemName: "party.popper.fill")
                                Image(systemName: "balloon.fill")
                                Image(systemName: "balloon")
                                Image(systemName: "party.popper.fill")
                            }.padding([.bottom], 20)
                            Button(
                                   action: { getAWSData() },
                                   label: {Text("Let's Go!")
                             .fontWeight(.bold)
                                .background(RoundedRectangle(cornerRadius: 40)
                                .foregroundColor(colorManager.getLavendar())
                                .padding(20)
                                .frame(width:300, height: 100))
                            .foregroundColor(Color.white)
                            .padding([.trailing], 20)
                        }).padding(10)
                        }
                        
                    }  else if(appController.viewController.homePage) {
                        HomeView(controller: appController, viewContext: viewContext, user: users.first!)
                    } else if(appController.viewController.userPage) {
                        UserView(controller: appController, viewContext: viewContext, user: users.first!)
                    }
                    
                }
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
