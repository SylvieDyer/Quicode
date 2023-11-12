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
import CoreData

struct UserView: View {
    var controller: AppController
    var viewContext: NSManagedObjectContext
    var user : User
    @State private var isActive = false
    
    var body:some View {
        NavigationView{
            VStack{
                // header
                HStack(alignment: .lastTextBaseline, spacing:0){
                    // home page
                    NavigationLink {
                        HomeView(controller: controller, viewContext: viewContext, user : user).navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "house").foregroundColor(.gray).padding(25)
                    }
                    Spacer()
                    Text("User Profile").font(.title3).bold().padding(.leading, 15)
                        .font(.callout).multilineTextAlignment(.center)
                    Spacer()
                    // login page navigation
//                    NavigationLink {
//                        IsLoginView()
//                    } label: {
//                        Image(systemName: "arrow.down.left.circle.fill").foregroundColor(.gray).padding(25)
//                    }
                    
                }
                List{
                    //profile section
                    VStack{
                        Text("\(user.firstName ?? "First Name") \(user.lastName ?? "Last Name")").font(.headline).multilineTextAlignment(.leading)
                        //TODO: take from user name
                        Text("\(user.email ?? "Email")").font(.caption).multilineTextAlignment(.leading)
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
                    }
                    NavigationLink(destination: LogoutView(controller: controller, viewContext: viewContext, user: user).navigationBarBackButtonHidden(), isActive: $isActive) {
                                            Button {
                                                // change user status
                                                user.isLoggedOut = true
                                                do {
                                                    try viewContext.save()
                                                } catch {
                                                    // TODO: Replace this implementation with code to handle the error appropriately.
                                                    
                                                    let nsError = error as NSError
                                                    // fatalError() will crash app
                                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                                }
                                                isActive = true
                                            } label: {
                                                Text("Sign Out").padding(10).foregroundColor(.indigo.opacity(0.7)).font(.headline)
                                            }
                                        }
                }.listStyle(InsetGroupedListStyle())
            }
        }
    }
}


// 
////// for testing when developing
//struct UserView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserView(controller: AppController(), user: User())
//    }
//}
