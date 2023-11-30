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
    @State var isSelected: [String:Bool] = [:]
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                ForEach(Array(question.getQuestionTextArr().enumerated()), id: \.element) { index, element in
                    if (element.last != ".") {
                        DropTemplate(number: index, text:element, dragInProgress: dragInProgress, question: question)
                    }
                    else if (element != "."){
                        Text(element)
                            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(dragInProgress ? (colorManager.getDarkGreen()) : colorManager.getMidGreen()))
                    }
                }
            }
            .opacity(isShown ? 1.0 : 0.0)
            .fontWeight(.bold)
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
                DragTemplate(option: question.questionOptions[$0], isSelected: $isSelected)
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
                        if isShown {
                            question.selected.forEach { key in
                                isSelected[key] = true
                            }
                        }
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
    @Binding var isSelected:[String:Bool]
    var body : some View {
        VStack{
            Spacer()
            Text(option)
                .font(.title2).foregroundColor(Color.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(isSelected[option] ?? false ? colorManager.getDarkGreen() : colorManager.getMidGreen())
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
    
    @State public var items = ["_______"]
    var number: Int
    
    // question text associated with this blank
    var text: String
    @State var dragInProgress: Bool
    var question: Question

    let colorManager: ColorManager = ColorManager()

    var body : some View {
        WrappingHStack(0...0) {_ in
            Text(text).allowsTightening(true).lineLimit(100).fixedSize(horizontal: false, vertical: true)
            VStack{
                Spacer()
                ForEach(items, id: \.self) { word in
                    Text(word)
                }
                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(dragInProgress ? (colorManager.getDarkGreen()) : colorManager.getMidGreen()))
                .onDrop(of: [UTType.plainText], delegate: self)
            }
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
            
        // append text of dropped item
        for item in info.itemProviders(for: [UTType.plainText]) {
            item.loadObject(ofClass: NSString.self) { item, error in
                if let str = item as? String {
                    items = [str]
                    question.selected[number] = items[0]
                }
            }
        }
        // mark drag as complete
        dragInProgress = false
        return true
    }

}

struct Drag_Preview : PreviewProvider {
    
    static var previews: some View {
        DragAndDropView(moduleName: "NAMEEE", controller: AppController(), questionList: QuestionList(qlist:[]), question: Question(questionType: QuestionType.dragAndDrop, questionText: "The data types (int) (double) (float) and (long) are used to represent,But (String) (Character) represent,.", questionOptions: ["Double", "String", "Boolean", "Integer"], questionAnswer: ["String", "Boolean"], questionDifficulty: QuestionDifficulty.easy))
    }
}
