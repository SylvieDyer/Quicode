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
    @State var question: Question?
    @State private var currentQuestionIndex = 0
    @State var shouldNavigateToNextQuestion = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        displayQuestion()
    }
    
    // Function to display the appropriate view based on question type
    @ViewBuilder
    private func displayQuestion() -> some View {
        if(question != nil) {
            switch question?.questionType {
            case .multiSelect, .multipleChoice:
                MultipleQView(moduleName: moduleName, controller: controller, question: question!)
            default:
                Text("**\(question!.questionText)**").font(.title2).fontWeight(.bold)
            }
        } else {
            ModuleView(name: moduleName, controller: controller)
        }
    }
}
    
//    // Callback function to move to the next question
//    private func moveToNextQuestion() {
//        question = question.nextQuestion!
//    }
