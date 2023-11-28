//
//  ModuleView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import SwiftUI

//TODO: fix navigation after questions have been answered
//question: Do we want to just have our own navigation, screw the back button?

// template for module pages 
struct ModuleView: View {
    
    let name: String
    let controller: AppController
    @State private var showOverview = false
    
    let colorManager: ColorManager = ColorManager()
    
    var body: some View {
        
        List {
            // module title
            Section{
                VStack{
                    HStack {
                        // Module Title
                        Text(name).foregroundColor(Color.black).font(.title2).fontWeight(.heavy)
                        Spacer()
                        // Help Button
                        Button(action: {showOverview.toggle()}) {
                            // help icon
                            Label("", systemImage: "questionmark").foregroundColor(.black)
                        }
                        // pop-up
                        .sheet(isPresented: $showOverview) {
                            DescView(controller: controller, blockName: name)    // view with content
                        }
                    }.padding(20)
                    // the blocks associated witht he module
                    HStack{
                        ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                            // TODO: Connect with user-status
                            // if blockName associated with complete , "star.fill"
                            Image(systemName: "star")
                        }
                        Spacer()
                    }.padding(10)
                }
                    
            }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLavendar()))
            
        
            
            // iterate through list of blocks
            ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                Section {
                    // individual module
                    NavigationLink(){
                        BlockView(moduleName: name, blockName: getBlockName(blockName: blockName), controller: controller)
                    }  label: {
                        VStack{
                            Spacer()
                            Text(blockName)
                            Spacer()
                        }
                    }
                    .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                    .padding(20)
                }
               
            }.padding([.bottom], 30)
            .listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightLavendar()))// color each list section
            
        }.listStyle(InsetGroupedListStyle())
    }

    func getBlockName(blockName:String) -> String{
        if blockName == "Data Types and Variables" {
            return "dataTypes"
        } else if blockName == " Operators" {
            return "operators"
        } else if blockName == " Boolean Expressions" {
            return "booleanExpressions"
        }
        return ""
    }
}


//// for testing when developing
//struct View_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(controller: AppController())
//    }
//}
//


//struct Previews_ModuleView_Previews: PreviewProvider {
//    static var previews: some View {
////        Text("Hello, World!")
//    }
//}
