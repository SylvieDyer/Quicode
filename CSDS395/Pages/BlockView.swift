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
    @State private var questionList: QuestionList = QuestionList(qlist: [])
    @State private var isNavigationActive = false
    @State private var currDifficulty = QuestionDifficulty.easy
    @State private var trueVal = true
    
    var body: some View {
        if isNavigationActive {
            QuestionView(blockName: blockName, questionDifficulty: currDifficulty, controller: controller, questionList: questionList)
        } else {
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
                        HStack{
                            Image(systemName: "star")
                            Image(systemName: "star")
                            Image(systemName: "star")
                            
                        }.padding(10)
                    }
                    
                }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightGreyLavendar()))
                    .padding([.bottom],10)
                
                // EASY
                Section {
                    // individual module
                    HStack{
                        Button("Easy", action: {
                            Task.detached {
                                do {
                                    let questions = try await controller.getQuestions(name: getMappedBlockName(blockName: blockName), difficulty: "easy")
                                    let mainQueue = DispatchQueue.main
                                    mainQueue.async {
                                        self.questionList = questions
                                        self.currDifficulty = QuestionDifficulty.easy
                                        self.isNavigationActive = true
                                        print("easy")
                                    }
                                } catch {
                                    print("Error fetching questions: \(error)")
                                }
                            }
                        })
                        .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                        .padding(20)
                        Spacer()
                        Image(systemName: "star")
                    }
                }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getLightGreen()))// color each list section
                
                // MEDIUM
                Section {
                    // individual module
                    HStack{
                        Button("Medium", action: {
                            Task.detached {
                                do {
                                    let questions = try await controller.getQuestions(name: getMappedBlockName(blockName: blockName), difficulty: "medium")
                                    let mainQueue = DispatchQueue.main
                                    mainQueue.async {
                                        self.questionList = questions
                                        self.currDifficulty = QuestionDifficulty.medium
                                        self.isNavigationActive = true
                                        print("medium")
                                    }
                                } catch {
                                    print("Error fetching questions: \(error)")
                                }
                            }
                        })
                        .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                        .padding(20)
                        Spacer()
                        Image(systemName: "star")
                    }
                }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getMidGreen()))// color each list section
                
                // HARD
                Section {
                    // individual module
                    HStack{
                        Button("Hard", action: {
                            Task.detached {
                                do {
                                    let questions = try await controller.getQuestions(name: getMappedBlockName(blockName: blockName), difficulty: "hard")
                                    let mainQueue = DispatchQueue.main
                                    mainQueue.async {
                                        self.questionList = questions
                                        self.currDifficulty = QuestionDifficulty.hard
                                        self.isNavigationActive = true
                                        print("hard")
                                    }
                                } catch {
                                    print("Error fetching questions: \(error)")
                                }
                            }
                        })
                        .foregroundColor(Color.black).font(.title3).fontWeight(.heavy)
                        .padding(20)
                        Spacer()
                        Image(systemName: "star")
                    }
                }.listRowBackground(RoundedRectangle(cornerRadius: 40).fill(colorManager.getDarkGreen()))// color each list section
                
            }.listStyle(InsetGroupedListStyle())
        }
    }
    
    
    func getMappedBlockName(blockName:String) -> String{
        return blockName.replacingOccurrences(of: " ", with: "")
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(moduleName:"MODULE", blockName:"BLOCK NAME", controller: AppController())
    }
}
