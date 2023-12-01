//
//  UserView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/5/23.
//

import SwiftUI

//setup:
/*
 name
 email
 ----
 progress tracker
 -> Module, completion percentage
 ->
 ---
 preferences
 Choose default language
 */

struct UserView: View {
    var controller: AppController
    var colorManager = ColorManager()
    
    var body:some View {
        
        VStack{
            // header
            HStack(spacing:0){
                ZStack{
                    // home page
                    HStack{
                        Button(
                            action: {
                                controller.viewController.setAsHome()},
                            label: {
                                Image(systemName: "house").foregroundColor(.black).padding(25)
                            })
                        Spacer()
                    }
                    // Title
                    HStack{
                        Spacer()
                        
                        Text("User Profile").font(.title2).bold()
                            .font(.callout)
                        Spacer()
                    }
                }
            }.frame(height: 50)
            List{
                Section{
                    //profile section
                    VStack(alignment:.leading){
                        Text("\(UserDefaults.standard.string(forKey: "firstname") ?? "First Name") \(UserDefaults.standard.string(forKey: "lastname") ?? "Last Name")").font(.title).bold()
                        //TODO: take from user name
                        Text("\(UserDefaults.standard.string(forKey: "email") ?? "Email")").font(.title3)
                    }
                    .padding([.leading], 10)
                }.listRowBackground(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(colorManager.getMidGreen().opacity(0.8)))
          
                //Progress Tracking Section
                Section{
                    Text("Your Progress:").font(.title2).fontWeight(.heavy).foregroundColor(.black).opacity(0.8)
                }.listRowBackground( RoundedRectangle(cornerRadius: 50).fill(colorManager.getColor(hex: "#f2f2f7")))
                                    // iterate through list of modules
                ForEach(controller.getModuleNames(), id: \.self) { moduleName in
                    Section{
                        VStack(alignment:.leading){
                            Text(moduleName).padding(.top, 10).bold()
                                Spacer()
                                // progress Bar
                                HStack{
                                    ForEach(controller.getBlocks(name: moduleName), id: \.self) { blockName in
                                        // TODO: Connect with user-status
                                        // if blockName associated with complete , "star.fill"
                                        Image(systemName: "star").foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                            }
                        
                        .padding(20)
                    }.listRowBackground(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(colorManager.getLightLavendar()))
                }
                
                
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    controller.viewController.setAsLogIn()
                    //                        TODO: implement log out functionality (core data, s3 saving progress, etc)
                }, label:{ Text("Logout").font(.title2).bold()})
            }.listStyle(InsetGroupedListStyle())
        }
    }
    
}


 
//// for testing when developing
struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView(controller: AppController())
    }
}
