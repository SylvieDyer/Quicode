//
//  MultipleQView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/6/23.
//

import SwiftUI

// for multiple choice and multi-select questions
struct MultipleQView: View {
    var body: some View {
        // use some sort of variable to track which option was selected (will have to higlight multiple if multi select
        var isSelected = false
        
        VStack{
            // question
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(Color.cyan.opacity(0.4))
                .padding(25)
                .frame(height: 400)
                .overlay(Text("Question").font(.title2).fontWeight(.bold))
            
            VStack{
                // options
                HStack{
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("OPTION 1").font(.title3).foregroundColor(.black))
                    }
                    
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("OPTION 2").font(.title3).foregroundColor(.black))
                    }
                }
                HStack{
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("OPTION 3").font(.title3).foregroundColor(.black))
                    }
                    
                    Button(action: {}){
                            RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.cyan.opacity(0.2))
                            .padding(10)
                            .frame(height: 200)
                            .overlay(Text("OPTION 4").font(.title3).foregroundColor(.black))
                    }
                }
                
            }
            Spacer()
        }.padding()
    }
}
    

//
//struct MultipleQView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleQView()
//    }
//}
