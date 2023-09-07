//
//  ModuleView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import SwiftUI

// template for module pages 
struct ModuleView: View {
  
    let name: String
    let controller: AppController
    
    @State private var showOverview = false
    var body: some View {
        
        VStack{
            HStack {
                // Module Title
                Text(name).foregroundColor(.indigo).font(.title2).fontWeight(.heavy)
                Spacer()
                // Help Button
                Button(action: {showOverview.toggle()}) {
                    // help icon
                    Label("", systemImage: "questionmark").foregroundColor(.gray)
                }
                // pop-up
                .sheet(isPresented: $showOverview) {
                    DescView(name: name)    // view with content
                }
            }.padding(.horizontal, 50)
            HStack{
                ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                    // TODO: Connect with user-status
                    // if blockName associated with complete , "star.fill"
                    Image(systemName: "star")
                }
            }.padding(.top, 10)
        }
        
        // the blocks associated witht he module
        List{
            // iterate through list of blocks
            ForEach(controller.getBlocks(name: name), id: \.self) { blockName in
                // individual module
                NavigationLink(blockName){
                    QuestionView(question: controller.getQuestions(name: blockName)[0]) //controller.getQuestions(name: blockName)[0].questionText
                }
                .foregroundColor(.indigo.opacity(0.7)).font(.title3).fontWeight(.heavy)
                .padding([.bottom], 50)
            }
        }
    }
}

// for testing when developing 
//struct View_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(controller: AppController())
//    }
//}
