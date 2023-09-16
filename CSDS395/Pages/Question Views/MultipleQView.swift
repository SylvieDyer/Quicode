//
//  MultipleQView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/6/23.
//

import SwiftUI


// for multiple choice and multi-select questions
struct MultipleQView: View {
    @State var question: Question
    @State var didTapOption: [String:Bool] = [:]
    
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
                
            ScrollView{
                // options
                ForEach(question.questionOptions, id: \.self) { option in
                    Button(action: {
                        if(option != question.questionAnswer[0]) {
                            didTapOption[option] = true
                            print(option+" "+String(didTapOption[option] ?? false))
                        }
                    }){
                        Text(option).font(.title3).foregroundColor(.black).padding(10)
                            .frame(width: 400, height: 100)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(didTapOption[option] ?? false ? Color.red.opacity(0.2) : Color.cyan.opacity(0.2))
                                .padding(10)
                                .frame(width:350, height: 100)
                                )
                    }
                }
            }
//            Spacer()
        }
    }
//    @IBAction func buttonTappesd(sender: AnyObject) {}

    func showText() {
        
    }
}


