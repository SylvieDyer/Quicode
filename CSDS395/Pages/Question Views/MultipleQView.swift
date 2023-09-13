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
        
        var options = question.questionOptions
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
                HStack{
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("1").font(.title3).foregroundColor(.black))
                    }
                    
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("2").font(.title3).foregroundColor(.black))
                    }
                }
                HStack{
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("3").font(.title3).foregroundColor(.black))
                    }
                    
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("4").font(.title3).foregroundColor(.black))
                    }
                }
                
            }
            Spacer()
        }.padding()
    }
}
    


//struct MultipleQView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleQView()
//    }
//}
