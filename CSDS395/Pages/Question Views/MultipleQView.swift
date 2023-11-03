//
//  MultipleQView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/6/23.
//

import SwiftUI


// for multiple choice and multi-select questions
struct MultipleQView: View {
    let moduleName: String
    let controller: AppController
    @State var nextQuestion: Question? = nil
    @State var questionList: QuestionList
    @State var question: Question
    @State var shouldNavigateToNextQuestion: Bool = false // Binding to the state in the parent view
    
    // dismisses entire question stream
    @Environment(\.dismiss) var dismiss
    
    @State var isShown = true
    
    @State var didTapIncorrectOption: [String:Bool] = [:]
    
    
    var body: some View {
        // use some sort of variable to track which option was selected (will have to higlight multiple if multi select
        VStack{
            // question
            Text(question.questionText).font(.title2).fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(50)
                .frame(width: 400, height: 200)
                .background(RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(Color.cyan.opacity(0.4))
                    .padding(50)
                    .frame(width:400, height: 300))
            
            
            ForEach(question.questionOptions, id: \.self) { option in
                Button(action: {
                    do {
                        if(!question.questionAnswer.contains(option)) {
                            didTapIncorrectOption[option] = true
                        } else {
                            // on answer, mark booleans as true/false (opacity --> 0)
                            question.isComplete = true
                            print("answered: ", option)
                            isShown = false
                        }
                    }
                }){
                    Text(option).font(.title3).foregroundColor(.black).padding(10)
                        .frame(width: 400, height: 100)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(didTapIncorrectOption[option] ?? false ? Color.red.opacity(0.2) : Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(width:350, height: 100)
                        )
                }
                
            }
        }.background(Color.white)
            .opacity(isShown ? 1.0 : 0.0)
    }
}

          


