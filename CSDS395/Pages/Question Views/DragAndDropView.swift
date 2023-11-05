//
//  DragAndDropView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/15/23.
//
import SwiftUI
import UniformTypeIdentifiers

struct DragAndDropView: View{
    let moduleName: String
    let controller: AppController
    @State var questionList: QuestionList
    @State var question: DragAndDropQ
//    @State public var options = ["cow", "type", "int", "name", "blah"]
//    @State public var questionText = ["A", "IS A", "."]
    @State private var dragInProgress = false
    
    var body: some View {
        
        VStack{
            
            HStack{
                ForEach(question.getQuestionTextArr(), id: \.self) { text in
                    if(text != ".") {
                        DropTemplate(text: text, dragInProgress: dragInProgress)
                    }
                }
            }
            
            HStack {
                ForEach(question.questionOptions, id: \.self) { option in
                    Text(option)
                        .onDrag {
                            NSItemProvider(object: option as NSString)
                        } preview: {
                            Text(option)
                        }
                }
            }
            
        }
    }
}


struct DropTemplate: View, DropDelegate{
    
    @State private var items = ["_______"]
    
    // question text associated with this blank
    var text: String
    @State var dragInProgress: Bool

    
    var body : some View {
        HStack {
            Text(text)
            ForEach(items, id: \.self) { word in
                Text(word)
            }
            .background(dragInProgress ? Color.orange : Color.blue)
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

//struct DragAndDropView_Previews: PreviewProvider {
//    static var previews: some View {
//        DragAndDropView()
//    }
//}
