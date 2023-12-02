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
    let colorManager: ColorManager = ColorManager()
    let hardCodedLastCompletedModule: String = "CS Foundations"
    @Environment (\.dismiss) var dismiss
    @State private var modulesValidMap: [String : Bool] = [:]
    
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
                    Button(
                        action: {
                            controller.viewController.setAsUser()},
                        label: {
                            Image(systemName: "person").foregroundColor(.gray).padding(25)
                        })
                }
                
                // section to replace when navigating btwn modules
                NavigationStack{
                    List{
                        // welcome section
                        Section{
                            // will be dynamic with user name -- Text("Welcome Back, \(user.name)
                            Text("Welcome Back, \(UserDefaults.standard.string(forKey: "firstname") ?? "User")").bold().font(.title2)
                            
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
                            if (modulesValidMap[moduleName] ?? true) {
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
                            } else {
                                Section{
                                // individual module
                                    Text(moduleName).padding(.top, 10)
                                    .frame(alignment: .center)
                                    .foregroundColor(.gray).font(.title3).fontWeight(.heavy)
                                    .padding([.bottom], 30)
                                }.padding([.bottom], 30)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(colorManager.getMidGreen())
                        ) // color each list section
                        
                    }.listStyle(InsetGroupedListStyle()) // (remove drop down option for list sectoins)
                    .onAppear() {
                        modulesValidMap = getModulesValidMap(lastCompleted: hardCodedLastCompletedModule)
                    }
                }
            }
        }
        
    }
    func getModulesValidMap(lastCompleted: String) -> [String : Bool] {
        var moduleMap: [String : Bool] = [:]
        var valid = true
        for moduleName in controller.getModuleNames(){
            moduleMap[moduleName] = valid
            if(moduleName == lastCompleted) {
                valid = false
            }
        }
        return moduleMap
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
