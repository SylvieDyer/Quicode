//
//  QuestionView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//

import SwiftUI

struct QuestionView: View {
    let blockName: String
    let questionDifficulty: QuestionDifficulty
    let controller: AppController
    @State var questionList: QuestionList
    
    
    @State var shouldNavigateToNextQuestion = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
          
            VStack{
                Text("You've completed the \(blockName) \(getStringQuestionDifficulty(questionDifficulty:questionDifficulty)) module!")
                switch (questionDifficulty) {
                case QuestionDifficulty.easy:
                    Text("Let's try something a little harder!")
                case QuestionDifficulty.medium:
                    Text("Time for a challenge!")
                case QuestionDifficulty.hard:
                    Text("3 Stars!")
                }
                Button(action: {dismiss.callAsFunction()}, label: {Text("Return to Modules")})
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
//    func getBlockNameFormatted(blockName:String) -> String {
//        return blockName.replacingOccurrences(of: " ", with: "")
////        if blockName == "dataTypes" {
////            return "Data Types and Variables"
////        } else if blockName == "operators"  {
////            return "Operators"
////        } else if blockName == "booleanExpressions"  {
////            return "Boolean Expressions"
////        }
////        return ""
//    }
    
    func getStringQuestionDifficulty(questionDifficulty:QuestionDifficulty) -> String {
        if questionDifficulty == QuestionDifficulty.easy {
            return "easy"
        } else if questionDifficulty == QuestionDifficulty.medium {
            return "medium"
        } else if questionDifficulty == QuestionDifficulty.hard {
            return "hard"
        }
        return ""
    }
}
