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
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
          
            VStack{
               Text("You've completed the \(moduleName) module!")
                Button(action: {dismiss.callAsFunction()}, label: {Text("Return to Modules")})
            }

            ForEach(questionList.qlist, id: \.self){ question in
                if (!question.isComplete){
                    switch (question.questionType){
                    case QuestionType.multipleChoice:
                        MultipleChoiceView(moduleName: moduleName, controller: controller,questionList: questionList, question: question)
                    case QuestionType.multiSelect:
                        MultiSelectView(moduleName: moduleName, controller: controller, questionList: questionList, question: question)
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
