//
//  DragAndDropView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/15/23.
//
import SwiftUI
import UniformTypeIdentifiers
import WrappingHStack

struct DragAndDropView: View{
    let moduleName: String
    let controller: AppController
    @State var questionList: QuestionList
    @State var question: Question
    
    let colorManager: ColorManager = ColorManager()
    @State private var dragInProgress = false
    
    @State var isShown = true   // to show the question 
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                ForEach(question.getQuestionTextArr(), id: \.self) { text in
                    if(text != ".") {
                        DropTemplate(text: text, dragInProgress: dragInProgress, question: question)
                    }
                }
            }
            .opacity(isShown ? 1.0 : 0.0)
            .font(.title2).fontWeight(.bold)
                .fixedSize(horizontal: true, vertical: true)
                .multilineTextAlignment(.center)
                .padding(50)
                .background(RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(colorManager.getMidGreen()
                    .opacity(isShown ? 1.0 : 0.0))
                    .padding(50)
                    .frame(width:400, height: 300))
            
            Spacer()
            
            WrappingHStack(0...question.questionOptions.count - 1, id:\.self, alignment: .center
            ) {
                DragTemplate(option: question.questionOptions[$0])
            }.frame(height: 300)
                .opacity(isShown ? 1.0 : 0.0)

            
            Spacer()
            HStack{
                Spacer()
                Button(
                    action: {
                        //TODO: won't move on unless right, but only one chance -- should: validate , add to extra list, move on.
                        // on answer, mark booleans as true/ false
                        isShown = !NextButton.validate(selected: question.selected, correct: question.questionAnswer, questionType: .dragAndDrop)
                    },
                    label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .background(RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(colorManager.getDarkGreen())
                            .padding(20)
                            .frame(width:100, height: 100))
                        .foregroundColor(Color.black)
                        .padding([.trailing], 20)
                    })
            }
            .padding([.bottom], 50)
            .opacity(isShown ? 1.0 : 0.0)
            
        }.background(colorManager.getLightGreen().opacity(isShown ? 1.0 : 0.0))
    }
}

// for draggable items
struct DragTemplate: View {
    var option: String
    
    let colorManager: ColorManager = ColorManager()
    var body : some View {
        VStack{
            Spacer()
            Text(option)
                .font(.title2).foregroundColor(Color.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(colorManager.getDarkGreen())
                )
                .onDrag {
                    NSItemProvider(object: option as NSString)
                } preview: {
                    Text(option)
                        .font(.title2).foregroundColor(Color.white)
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(colorManager.getDarkGreen())
                        )
                }
            Spacer()
        }
    }
}
             
// for drop locations
struct DropTemplate: View, DropDelegate{
    
    @State private var items = ["_______"]
    
    // question text associated with this blank
    var text: String
    @State var dragInProgress: Bool
    var question: Question

    let colorManager: ColorManager = ColorManager()

    var body : some View {
        HStack {
            Text(text)
            ForEach(items, id: \.self) { word in
                Text(word)
            }
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(dragInProgress ? colorManager.getDarkGreen() : colorManager.getMidGreen()))
            .onDrop(of: [UTType.plainText], delegate: self)
        }
    }
    
    // when the drop area has been entered (by droppable)
    func dropEntered(info: DropInfo) {
        print("dropEntered")
        dragInProgress = info.hasItemsConforming(to: [UTType.plainText])
    }
    
    // when the drop area has been exited (by droppable)
    func dropExited(info: DropInfo) {
        dragInProgress = false
    }
    
    // when drop occurs
    func performDrop(info: DropInfo) -> Bool {
        // if drop was already performed, do not perform again
        if (items[0] != "_______"){
            return false
        }
            
        // append text of dropped item
        for item in info.itemProviders(for: [UTType.plainText]) {
            item.loadObject(ofClass: NSString.self) { item, error in
                if let str = item as? String {
                    items = [str]
                    question.selected.insert(items[0], at: question.getQuestionTextArr().firstIndex(of: text) ?? -1)
                }
            }
        }
        // mark drag as complete
        dragInProgress = false
        return true
    }

}
