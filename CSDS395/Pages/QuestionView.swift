//
//  QuestionView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//

import SwiftUI

struct QuestionView: View {
    @State var question: Question?
    @State private var currentQuestionIndex = 0
    @State var shouldNavigateToNextQuestion = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        displayQuestion()
            .onAppear {
                do {
                    print(question?.questionText)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
                
            }
    }
    
    @ViewBuilder
    private func displayMumboJumbo() -> some View {
        Text("mumbo jumbo")
    }
    
    // Function to display the appropriate view based on question type
    @ViewBuilder
    private func displayQuestion() -> some View {
        if(question != nil) {
            switch question?.questionType {
            case .multiSelect, .multipleChoice:
                MultipleQView(question: question!)
            default:
                Text("**\(question!.questionText)**").font(.title2).fontWeight(.bold)
            }
        }
    }
}
    
//    // Callback function to move to the next question
//    private func moveToNextQuestion() {
//        question = question.nextQuestion!
//    }
