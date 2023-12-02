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
    var dbManager : DBManager = DBManager()
    
    var colorManager = ColorManager()
    
    var body: some View {
        // open login if logged out / is redirected
        if (appController.viewController.logInPage && !UserDefaults.standard.bool(forKey: "isLoggedIn")){
            LoginView(appController: appController, awsManager: awsManager, dbManager: dbManager, authenticationSuccess: {
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
                // otherwise if directed home
                }  else if(appController.viewController.homePage) {
                    HomeView(controller: appController)
                // otherwise if directed to user page
                } else if(appController.viewController.userPage) {
                    UserView(controller: appController)
                }
            }
        }
    }
    
    func getAWSData(){
        Task{
            do {
                await appController.setAppInfo(awsManager: awsManager)
                appController.viewController.setAsHome()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                loadedModules.toggle()
            }
        }
    }
}
