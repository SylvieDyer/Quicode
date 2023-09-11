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
        NavigationStack{
            List{
                // welcome section
                Section{
                    Text("User Profile")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                //profile section
                Section{
                    Text("Name")
                }
                // "quick code" section
                Section{
                    HStack{ // to center text
                        Spacer()
                        NavigationLink{
                            ModuleView(name: "Quick Lesson", controller: controller)
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
                
                Section{
                    // iterate through list of modules
                    ForEach(controller.getModuleNames(), id: \.self) { moduleName in
                        // individual module
                        NavigationLink(){
                            ModuleView(name: moduleName, controller: controller)
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
                                        Image(systemName: "star").foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        
                        .foregroundColor(.indigo.opacity(0.7)).font(.title3).fontWeight(.heavy)
                        .padding([.bottom], 30)
                    }
                }
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
