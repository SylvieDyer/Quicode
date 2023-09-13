//
//  MultipleQView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/6/23.
//

import SwiftUI

// for multiple choice and multi-select questions
struct MultipleQView: View {
    let question: Question
    var body: some View {
        // use some sort of variable to track which option was selected (will have to higlight multiple if multi select
        var isSelected = false
        
        let options: [String] = question.questionOptions
        var answer = question.questionAnswer
        
        VStack{
            // question
            Text(question.questionText).font(.title2).fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(50)
                .frame(width: 400, height: 300)
                .background(RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(Color.cyan.opacity(0.4))
                    .padding(50)
                    .frame(width:400, height: 300))
                
            VStack{
                // options
                ForEach(options, id: \.self) { option in
                    Button(action: {}){
                        Text(option).font(.title3).foregroundColor(.black).padding(10)
                            .frame(width: 400, height: 100)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.cyan.opacity(0.2))
                                .padding(10)
                                .frame(width:400, height: 100))
                    }
                }
            }.padding(10)
            Spacer()
        }
    }
}
