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
    var user : User
    let hardCodedLastCompletedModule: String = "Operators"
    @State private var showOverview = false
    @State private var blocksValidMap: [String : Bool] = [:]
    
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
            .onAppear() {
                blocksValidMap = getBlocksValidMap(lastCompleted: hardCodedLastCompletedModule)
            }
            
        
            
            // iterate through list of blocks
            ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                Section {
                    // individual module
                    VStack{
                        if (blocksValidMap[blockName] ?? true) {
                            NavigationLink(destination: BlockView(moduleName: name, blockName: blockName, controller: controller, user: user)) {
                                Text(blockName)
                                    .foregroundColor(Color.black)
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .padding(20)
                                HStack {
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star" )
                                }
                            }
                        } else {
                            Text(blockName)
                                .foregroundColor(Color.gray)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .padding(20)
                        }
                    }
                }
               
            }.padding([.bottom], 20)
            .listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightLavendar()))// color each list section
            
        }.listStyle(InsetGroupedListStyle())
    }
   
    func getBlocksValidMap(lastCompleted: String) -> [String : Bool] {
        var blockMap: [String : Bool] = [:]
        var valid = true
        for blockName in controller.getBlocks(name: name){
            blockMap[blockName] = valid
            if(blockName == lastCompleted) {
                valid = false
            }
        }
        return blockMap
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
