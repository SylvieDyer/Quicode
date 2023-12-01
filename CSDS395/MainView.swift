//
//  MainView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/19/23.
//

import SwiftUI

// entry-point view for application
struct MainView: View {
    @ObservedObject var appController: AppController
    
   
    @State private var loadedModules = false
    var awsManager : AWSManager = AWSManager()
    
    var colorManager = ColorManager()
    
    /// SOLEY FOR TESTING PURPOSES ( content previewing)
    //    var isTestingSinglePage: Bool
    
    var body: some View {
        
        if (appController.viewController.logInPage && !UserDefaults.standard.bool(forKey: "isLoggedIn")){
            LoginView(appController: appController, awsManager: awsManager, authenticationSuccess: {
                appController.viewController.setAsHome()
            })
        }
        else {
            VStack {
                // if need to load from S3, show popup
                if (!loadedModules){
                    VStack {
                        Text("Hello, \(UserDefaults.standard.string(forKey: "firstname") ?? "User") ").font(.title)
                        Text("QUICk! are you ready to CODE?!?!?!")
                            .font(.title2)
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
                            action: { getAWSData()},
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
                    HomeView(controller: appController)
                } else if(appController.viewController.userPage) {
                    UserView(controller: appController)
                }
                
                
            }
        }
    }
    
    func getAWSData(){
        Task{
            do {
                print("button hit")
                await appController.setAppInfo(awsManager: awsManager)
                appController.viewController.setAsHome()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                loadedModules.toggle()
            }
        }
    }
}
