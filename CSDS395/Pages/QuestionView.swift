//
//  QuestionView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//

import SwiftUI

struct QuestionView: View {
    let moduleName: String
    let blockName: String
    let questionDifficulty: QuestionDifficulty
    let controller: AppController
    let dbManager : DBManager = DBManager()
    @State var questionList: QuestionList
    var colorManager = ColorManager()
    @State private var userID: String = UserDefaults.standard.string(forKey: "id") ?? "ID"
    
    @State var shouldNavigateToNextQuestion = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
          
            VStack {
                Text("You've completed").font(.title2).bold()
                
                Text("\(blockName)").font(.title).bold().multilineTextAlignment(.center)
                Text("Difficulty: \(getStringQuestionDifficulty(questionDifficulty:questionDifficulty))").font(.title2).bold().multilineTextAlignment(.center)
                    .padding([.bottom], 20)
                
                switch (questionDifficulty) {
                case QuestionDifficulty.easy:
                    Text("Let's try something a little harder!").font(.title3).padding([.bottom], 15)
                case QuestionDifficulty.medium:
                    Text("Time for a challenge!").font(.title3).padding([.bottom], 15)
                case QuestionDifficulty.hard:
                    Text("3 Stars!").font(.title3).padding([.bottom], 15)
                }
                
                
                Button(action: {dismiss.callAsFunction(); updateDB();}, label: {Text("Return to Modules") .fontWeight(.bold)
                        .background(RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(colorManager.getLavendar())
                            .padding(20)
                            .frame(width:300, height: 100))
                        .foregroundColor(Color.white)
                        .padding([.trailing], 20)
                }).padding(10)
            }
            

            ForEach(questionList.qlist, id: \.self){ question in
                if (!question.isComplete){
                    switch (question.questionType){
                    case QuestionType.multipleChoice:
                        MultipleChoiceView(moduleName: blockName, controller: controller,questionList: questionList, question: question)
                    case QuestionType.multiSelect:
                        MultiSelectView(moduleName: blockName, controller: controller, questionList: questionList, question: question)
                    case QuestionType.dragAndDrop:
                        DragAndDropView(moduleName: blockName, controller: controller, questionList: questionList, question: question)
                    default:
                        Text("BLANK")
                    }
                }
            }
        }
    }

    func getStringQuestionDifficulty(questionDifficulty:QuestionDifficulty) -> String {
        if questionDifficulty == QuestionDifficulty.easy {
            return "Easy"
        } else if questionDifficulty == QuestionDifficulty.medium {
            return "Medium"
        } else if questionDifficulty == QuestionDifficulty.hard {
            return "Hard"
        }
        return ""
    }
    
    func updateDB() {
        Task {
            do{
                let response = await queryDB();
                if(ProgressUtils.getValue(inputValue: ["\(blockName)","\(questionDifficulty)"]) > ProgressUtils.getValue(inputValue: [response["blockName"] ?? "", response["questionDifficulty"] ?? ""])){
                    await dbManager.updateDB(
                        key: ["userID" : .s("\(userID)")],
                        expressionAttributeValues: [":newModuleName" : .s("\(moduleName)"), ":newBlockName": .s("\(blockName)"), ":newQuestionDifficulty": .s("\(questionDifficulty)")],
                        updateExpression: "SET moduleName = :newModuleName, blockName = :newBlockName, questionDifficulty = :newQuestionDifficulty")
                }
            }
        }
    }
    
    func queryDB() async -> [String : String]{
        let response = await dbManager.queryDB(userID: userID)
        return response;
    }
}
//
//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(blockName: "Data Types and Variables", questionDifficulty: QuestionDifficulty.easy, controller: AppController(), questionList: QuestionList(qlist: []))
//    }
//}
