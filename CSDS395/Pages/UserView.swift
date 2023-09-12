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
    
    var body:some View {
        NavigationView{
            VStack{
                // header
                HStack(alignment: .lastTextBaseline, spacing:0){
                    // home page
                    NavigationLink {
                        HomeView(controller: controller).navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "house").foregroundColor(.gray).padding(25)
                    }
                    Spacer()
                    Text("User Profile").font(.title3).bold().padding(.leading, 15)
                        .font(.callout).multilineTextAlignment(.center)
                    Spacer()
                    // login page navigation
                    NavigationLink {
                        IsLoginView()
                    } label: {
                        Image(systemName: "arrow.down.left.circle.fill").foregroundColor(.gray).padding(25)
                    }
                    
                }
                List{
                    //profile section
                    VStack{
                        Text("Ana Perez").font(.headline).multilineTextAlignment(.leading)
                        //TODO: take from user name
                        Text("alp133@case.edu").font(.caption).multilineTextAlignment(.leading)
                    }
                    //Progress Tracking Section
                    Section{
                        Text("Progress") .foregroundColor(.green.opacity(0.6)).font(.title2).fontWeight(.heavy)
                        //get user's last module and how far they've gotten
                        // iterate through list of modules
                        ForEach(controller.getModuleNames(), id: \.self) { moduleName in
                            // individual module
                            Text(moduleName).padding(.top, 10)
                            // progress Bar
                            HStack{
                                ForEach(controller.getBlocks(name: moduleName), id: \.self) { blockName in
                                    // TODO: Connect with user-status
                                    // if blockName associated with complete , "star.fill"
                                    Image(systemName: "star").foregroundColor(.gray)
                                }
                            }
                            .foregroundColor(.indigo.opacity(0.7)).font(.title3).fontWeight(.heavy)
                        }
                    }
                    Section{
                        Text("Preferences") .foregroundColor(.purple.opacity(0.6)).font(.title2).fontWeight(.heavy)
                        //get user's last module and how far they've gotten
                        // iterate through list of modules
                        Text("Sign Out").padding(10) //TODO
                            .foregroundColor(.indigo.opacity(0.7)).font(.headline)
                    }
                }.listStyle(InsetGroupedListStyle())
            }
        }
    }
}


// for testing when developing
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(controller: AppController())
    }
}
//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(controller: <#T##AppController#>())
//    }
//}
