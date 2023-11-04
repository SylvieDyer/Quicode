//
//  QuestionView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//

import SwiftUI

struct QuestionView: View {
    let moduleName: String
    let controller: AppController
    @State var questionList: QuestionList
    
    
    @State var shouldNavigateToNextQuestion = false
    
    var body: some View {
        ZStack{
            ModuleView(name: moduleName, controller: controller)

            ForEach(questionList.qlist, id: \.self){ question in
                if (!question.isComplete){
                    switch (question.questionType){
                    case QuestionType.multipleChoice:
                        MultipleQView(moduleName: moduleName, controller: controller,questionList: questionList, question: question)

                    case QuestionType.multiSelect:
                        MultipleQView(moduleName: moduleName, controller: controller, questionList: questionList, question: question)
                    case QuestionType.dragAndDrop:
                        DragAndDropView(moduleName: moduleName, controller: controller, questionList: questionList, question: question)
                    default:
                        Text("BLANK")
                    }
                }
            }
        }
    }
}
    
    
    // Function to display the appropriate view based on question type
//    @ViewBuilder
//    private func displayQuestion() -> some View {
//
//            switch question.questionType {
//            case .multiSelect:
//                MultipleQView(moduleName: moduleName, controller: controller, questionList: questionList, question: questionList.getCurrent()!)
//            case .dragAndDrop:
//                DragAndDropView(moduleName: moduleName, controller: controller, questionList: questionList, question: questionList.getCurrent()! as! DragAndDropQ)
//            default:
//                Text("**\(questionList.getCurrent()!.questionText)**").font(.title2).fontWeight(.bold)
//            }
//
//            switch questionList.getCurrent()?.questionType {
//            case .multiSelect:
//                MultipleQView(moduleName: moduleName, controller: controller, questionList: questionList, question: questionList.getCurrent()!)
//            case .dragAndDrop:
//                DragAndDropView(moduleName: moduleName, controller: controller, questionList: questionList, question: questionList.getCurrent()! as! DragAndDropQ)
//            default:
//                Text("**\(questionList.getCurrent()!.questionText)**").font(.title2).fontWeight(.bold)
//            }
//        } else {
//            ModuleView(name: moduleName, controller: controller)
//        }
//    }
//}
    
//    // Callback function to move to the next question
//    private func moveToNextQuestion() {
//        question = question.nextQuestion!
//    }
