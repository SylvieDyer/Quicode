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
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                ForEach(question.getQuestionTextArr(), id: \.self) { text in
                    if(text != ".") {
                        DropTemplate(text: text, dragInProgress: dragInProgress)
                    }
                }
            }.font(.title2).fontWeight(.bold)
                .fixedSize(horizontal: true, vertical: true)
                .multilineTextAlignment(.center)
                .padding(50)
                .background(RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(colorManager.getMidGreen())
                    .padding(50)
                    .frame(width:400, height: 300))
            
            Spacer()
            
            WrappingHStack(0...question.questionOptions.count - 1, id:\.self, alignment: .center
            ) {
                DragTemplate(option: question.questionOptions[$0])
            }.frame(height: 300)
            
            Spacer()
            
        }.background(colorManager.getLightGreen())
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
                .font(.title2).foregroundColor(Color.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(colorManager.getDarkGreen())
                )
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
        // append text of dropped item
        for item in info.itemProviders(for: [UTType.plainText]) {
            item.loadObject(ofClass: NSString.self) { item, error in
                if let str = item as? String {
                    items = [str]
                }
            }
        }
        // mark drag as complete
        dragInProgress = false
        return true
    }

}
