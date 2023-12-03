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
    let dbManager : DBManager = DBManager()
    @State private var showOverview = false
    @State private var blocksValidMap: [String : Bool] = [:]
    @State private var userID: String = UserDefaults.standard.string(forKey: "id") ?? "ID"
    @State private var lastCompleted : [String] = []
    
    let colorManager: ColorManager = ColorManager()
    var body: some View {
        VStack{
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
                        Image(systemName: "person").foregroundColor(.gray).padding(.horizontal, 15)
                    })
            }.padding(.bottom, -5)
            List {
                // module title
                Section{
                    VStack{
                        HStack {
                            // Module Title
                            Text(name).foregroundColor(Color.black).font(.title2).fontWeight(.heavy)
                            Spacer()
                            //  Help Button
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
                                if(ProgressUtils.getValue(inputValue: [blockName]) <= ProgressUtils.getValue(inputValue: lastCompleted) - 3) {
                                    Image(systemName: "star.fill").foregroundColor(.black)
                                }
                                else {
                                    Image(systemName: "star").foregroundColor(.black)
                                }
                            }
                            Spacer()
                        }.padding(10)
                    }
                    
                }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLavendar()))
                
                
                
                // iterate through list of blocks
                ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                    Section {
                        // individual module
                        VStack{
                            let blockVal = ProgressUtils.getValue(inputValue: [blockName])
                            if (ProgressUtils.isFirstBlock(blockVal: blockVal) || blocksValidMap[blockName] ?? true) {
                                NavigationLink(destination: BlockView(moduleName: name, blockName: blockName, controller: controller)) {
                                    Text(blockName)
                                        .foregroundColor(Color.black)
                                        .font(.title3)
                                        .fontWeight(.heavy)
                                        .padding(20)
                                    HStack {
                                        let difficulties = ["easy", "medium","hard"]
                                        ForEach(difficulties, id: \.self) { difficulty in
                                            if(ProgressUtils.getValue(inputValue: [blockName, difficulty]) <= ProgressUtils.getValue(inputValue: lastCompleted)) {
                                                Image(systemName: "star.fill")
                                            }
                                            else {
                                                Image(systemName: "star")
                                            }
                                        }
                                    }
                                }
                            }
                            else {
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
        .onAppear() {
            Task{
                do {
                    lastCompleted =  await queryBlockAndDifficulty()
                    blocksValidMap = getBlocksValidMap(lastCompleted: lastCompleted)
                }
            }
        }
    }
   
    func getBlocksValidMap(lastCompleted: [String?]) -> [String : Bool] {
        var blockMap: [String : Bool] = [:]
        var valid = true
        let progressBlockVal = ProgressUtils.getValue(inputValue: [lastCompleted[0] ?? ""])
        let progressDifficultyVal = ProgressUtils.getValue(inputValue: [lastCompleted[1] ?? ""])
        
        for blockName in controller.getBlocks(name: name){
            let thisBlockVal = ProgressUtils.getValue(inputValue: [blockName])
            //alt solution to integer mapping: make this get the difficulty and use it
            if(thisBlockVal <= progressBlockVal || (thisBlockVal == progressBlockVal + 10 && progressDifficultyVal == 3)) {
                blockMap[blockName] = true
            } else {
                blockMap[blockName] = false
            }
        }
        return blockMap
    }
    
    func queryBlockName() async -> String?{
        let response = await dbManager.queryDB(userID: userID)
        return response["blockName"]
    }
    
    func queryDifficulty() async -> String?{
        let response = await dbManager.queryDB(userID: userID)
        return response["questionDifficulty"]
    }
    
    func queryModuleName() async -> String?{
        let response = await dbManager.queryDB(userID: userID)
        return response["moduleName"]
    }
    
    func queryBlockAndDifficulty() async -> [String] {
        let response = await dbManager.queryDB(userID: userID)
        return [response["blockName"] ?? "", response["questionDifficulty"] ?? ""]
    }
}
