//
//  HomeView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI
import CoreData


struct HomeView: View {
    // stores module names
    @ObservedObject var controller: AppController
//    var awsManager : AWSManager = AWSManager()
    var viewContext: NSManagedObjectContext
    var user : User
    let colorManager: ColorManager = ColorManager()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        // wraps app in navigation to switch to user-screen
        NavigationView{
            VStack {
                // header
                HStack(alignment: .lastTextBaseline, spacing:0){
                    Text("QUICODE").font(.largeTitle).bold().padding(.leading, 15)
                        .fontWidth(.expanded)
                        .font(.callout)
                    Spacer()
                    
                    /// commented out for now... will be log out button in UserPage?
                    // sign in with apple page
                    /*
                     NavigationLink {
                     IsLoginView()
                     } label: {
                     Image(systemName: "arrow.down.left.circle.fill").foregroundColor(.gray).padding(25)
                     */
                    
                    // user page navigation
                    //                    NavigationLink {
                    //                        UserView(controller: controller, viewContext: viewContext, user: user, dismiss: dismiss).navigationBarBackButtonHidden(true)
                    //                    } label: {
                    //                        Image(systemName: "person").foregroundColor(.gray).padding(25)
                    //                    }
                    Button(action: {controller.viewController.setAsUser()}, label: {
                        Image(systemName: "person").foregroundColor(.gray).padding(25)
                    })
                }
                
                // section to replace when navigating btwn modules
                NavigationStack{
                    List{
                        // welcome section
                        Section{
                            // will be dynamic with user name -- Text("Welcome Back, \(user.name)
                            Text("Welcome Back, \(user.firstName ?? UserDefaults.standard.string(forKey: "firstname") ?? "firstname")").bold().font(.title2)
                            
                        }
                        .listRowBackground(
                            Capsule()
                                .fill(colorManager.getDarkGreen())
                        )
                        
                        // "quick code" section
                        Section{
                            HStack{ // to center text
                                Spacer()
                                NavigationLink{
                                    ModuleView(name: "Quick Lesson", controller: controller, user: user)
                                } label: {
                                    VStack{
                                        Text("Today's Quick Lesson:") .foregroundColor(.cyan.opacity(0.7)).font(.title2).fontWeight(.heavy)
                                        Text("Common Mistakes") .foregroundColor(.red.opacity(0.7)).font(.title3).fontWeight(.heavy)
                                    }
                                }
                                .padding(20)
                                Spacer()
                            }
                        }
                        
                        // iterate through list of modules
                        ForEach(controller.getModuleNames(), id: \.self) { moduleName in
                            Section{
                                // individual module
                                NavigationLink(){
                                    ModuleView(name: moduleName, controller: controller, user: user)
                                } label: {
                                    VStack{
                                        Text(moduleName).padding(.top, 10)
                                        Spacer()
                                        // progress Bar
                                        HStack{
                                            Spacer()
                                            ForEach(controller.getBlocks(name: moduleName), id: \.self) { blockName in
                                                // TODO: Connect with user-status
                                                // if blockName associated with complete , "star.fill"
                                                Image(systemName: "star").foregroundColor(.black)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                .foregroundColor(.black).font(.title3).fontWeight(.heavy)
                                .padding([.bottom], 30)
                            }.padding([.bottom], 30)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(colorManager.getMidGreen())
                        ) // color each list section
                        
                    }.listStyle(InsetGroupedListStyle()) // (remove drop down option for list sectoins)
                }
            }
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//
//    // for core data
////    let userDataController = UserDataController.shared
//
//    static var previews: some View {
//        // for core data
//        let userDataController = UserDataController.shared
//        // preview enter in MainView
//        MainView(appController: AppController())
//            .environment(\.managedObjectContext, userDataController.container.viewContext)
//
//    }
//}
