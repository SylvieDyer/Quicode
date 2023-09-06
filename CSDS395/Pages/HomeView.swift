//
//  ContentView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // stores module names
    var controller: AppController
    
    var body: some View {
        // wraps app in navigation to switch to user-screen
        NavigationView{
            VStack {
                
                // header
                HStack(alignment: .lastTextBaseline, spacing:0){
                    Text("QUICCODE").font(.largeTitle).bold().padding(.leading, 15)
                        .fontWidth(.expanded)
                        .font(.callout)
                    Spacer()
                    
                    // user page navigation
                    NavigationLink {
                        UserView()
                    } label: {
                        Image(systemName: "person").foregroundColor(.gray).padding(25)
                    }
                }
                
                // section to replace when navigating btwn modules
                NavigationStack{
                    List{
                        // welcome section
                        Section{
                            // will be dynamic with user name -- Text("Welcome Back, \(user.name)")
                            Text("Welcome Back, USER").bold().font(.title2)
                            // can include streak here?
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
                                NavigationLink(moduleName){
                                    ModuleView(name: moduleName, controller: controller)
                                }
                                .foregroundColor(.indigo.opacity(0.7)).font(.title3).fontWeight(.heavy)
                                .padding([.bottom], 50)
                            }
                        }
                    }.listStyle(InsetGroupedListStyle()) // (remove drop down option for list sectoins)
                }
            }
        }
    }
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(controller: AppController())
    }
}
