//
//  BlockView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 11/16/23.
//

import SwiftUI

struct BlockView: View {
    
    var moduleName: String
    var blockName: String
    var controller: AppController
    @State private var showOverview = false
    let colorManager: ColorManager = ColorManager()
    
    var body: some View {
        List {
            // block title
            Section{
                VStack{
                    Spacer()
                    HStack {
                        VStack(alignment:.leading){
                            // Module Title
                            Text(moduleName).foregroundColor(Color.black).font(.title2).fontWeight(.bold)
                            
                            Text(blockName).foregroundColor(Color.black).font(.title).fontWeight(.heavy)
                        }
                        Spacer()
                        // Help Button
                        Button(action: {showOverview.toggle()}) {
                            // help icon
                            Label("", systemImage: "questionmark").foregroundColor(.black)
                        }
                        // pop-up
                        .sheet(isPresented: $showOverview) {
                            DescView(controller: controller, blockName: blockName)    // view with content for current block
                        }
                    }.padding(20)
                }
                
            }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightGreyLavendar()))
                .padding([.bottom], 50)
      
            // EASY
            Section {
                // individual module
                NavigationLink(){
                    QuestionView(moduleName: moduleName, controller: controller, questionList: controller.getQuestions(name: blockName))
                    
                }  label: {
                    VStack{
                        Spacer()
                        Text("Easy")
                        Spacer()
                    }
                }
                .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                .padding(20)
            }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightGreen()))// color each list section
            
            // MEDIUM
            Section {
                // individual module
                NavigationLink(){
                    QuestionView(moduleName: moduleName, controller: controller, questionList: controller.getQuestions(name: blockName))
                    
                }  label: {
                    VStack{
                        Spacer()
                        Text("Medium")
                        Spacer()
                    }
                }
                .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                .padding(20)
            }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getMidGreen()))// color each list section
            
            // HARD
            Section {
                // individual module
                NavigationLink(){
                    QuestionView(moduleName: moduleName, controller: controller, questionList: controller.getQuestions(name: blockName))
                    
                }  label: {
                    VStack{
                        Spacer()
                        Text("Hard")
                        Spacer()
                    }
                }
                .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                .padding(20)
            }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getDarkGreen()))// color each list section
            
        }.listStyle(InsetGroupedListStyle())
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(moduleName:"MODULE", blockName:"BLOCK NAME", controller: AppController())
    }
}
