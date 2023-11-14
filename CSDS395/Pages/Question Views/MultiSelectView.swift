//
//  MultiSelectView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 11/14/23.
//

import SwiftUI


// for multiple choice and multi-select questions
struct MultiSelectView: View {
    let moduleName: String
    let controller: AppController
    @State var nextQuestion: Question? = nil
    @State var questionList: QuestionList
    @State var question: Question
    
    @State var isShown = true
    
    @State var didTapIncorrectOption: [String:Bool] = [:]
    @State var isSelected: [String:Bool] = [:]

    
    let colorManager: ColorManager = ColorManager()
    
    
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
                    .foregroundColor(colorManager.getLavendar())
                    .padding(50)
                    .frame(width:400, height: 300))
            
            
            ForEach(question.questionOptions, id: \.self) { option in
                Button(action: {
                    print("is selected: ", option)
                    // mark option as selected
                    if question.selected.contains(option) {
                        question.selected.removeAll(where: { $0 == option })
                        isSelected[option] = false
                    } else {
                        question.selected.append(option)
                        isSelected[option] = true
                    }
                    print("selected:", question.selected)
                    

                }){
                    Text(option)
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(10)
                        .frame(width: 400, height: 95)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(didTapIncorrectOption[option] ?? false ? Color.red.opacity(0.2) : (isSelected[option] ?? false ? colorManager.getLavendar() : colorManager.getLightLavendar()))
                            .frame(width:350, height: 90))
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button(
                    action: {
                        // if still shown, change color
                        isSelected.forEach { (key: String, value: Bool) in
                            print("in is selected")
                            print(key)
                            print(value)
                            
                            // if is selected, is WRONG
                            if (isSelected[key] == true){
                                isSelected[key] = false
                                didTapIncorrectOption[key] = true
                            }
                        }
                        // on answer, mark booleans as true/ false
                        isShown = !NextButton.validate(selected: question.selected, correct: question.questionAnswer, questionType: .multiSelect)
                        
        
                    },
                    label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .background(RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(colorManager.getDarkGreen())
                            .padding(20)
                            .frame(width:100, height: 100))
                        .foregroundColor(Color.white)
                        .padding([.trailing], 20)
                    }).padding(10)
            }
            .padding([.bottom], 50)
        }.background(colorManager.getLightGreen())
            .opacity(isShown ? 1.0 : 0.0)
    }
}

          


