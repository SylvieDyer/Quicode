////
////  DragAndDropView.swift
////  CSDS395
////
////  Created by Sylvie Dyer on 9/15/23.
////
//
//import SwiftUI
//import DragAndDrop
//
//struct DragAndDropView: View {
//
//    @ObservedObject var DNDCLASS : AppController.DND
//
//    //    var question: Question
//    // PLACE HOLDER FOR QUESTION
//    let questionText = ["question text 1", "question text 2"]
////    let dragText = ["blank 1", "blank2"]
//    let questionAnswers = ["Integer", "Type"]
//    let questionOptions = ["Variable", "Cow", "Type", "Pencil", "Integer"]
//
//    @State var currSelected: String = ""
//
//
//
////    ["hello this precedes the first blank", " and this is ethe second ", " and third"]
////
////    hello this preced the first blank _ and this is the second _ and third
////
////    for (array length - 1 times) {
////        allow drop
////    }
////
//    var body: some View {
////        InteractiveDragDropContainer{
////            HStack{
////                ForEach(Array(questionText.enumerated()), id: \.offset)  { index, word in
////                    Text(word)
////                    DropView { DropInfo in
////                        Text("_____")
////                    }
////                }
////            }
////            HStack{
////                ForEach(questionOptions, id: \.self) { option in
////                    DragView(id: UUID()) { dragInfo in
////                        Text(option)
////                            .padding()
////                            .background{
////                                dragInfo.isDragging ? Color.blue : Color.mint
////                            }
////                    }
////                }
////            }
////        }
//
//        InteractiveDragDropContainer{
//            VStack{
//                HStack{
//                    ForEach(Array(questionText.enumerated()), id: \.offset) { index, word in
//                        Text(word)
//                        DropView { dropInfo in
//                            Text(dropInfo.didDrop ? currSelected : "BLANK")
//                                .padding()
//                                .background{
//                                    dropInfo.isColliding ? Color.green : Color.red
//                                }
//                        }
//                        .onDragViewReceived { receivingViewID in
//                            DNDCLASS.setVal(word: word, id: receivingViewID)
//                        }
//                    }
//                }
//                HStack{
//                    ForEach(questionOptions, id: \.self) { option in
//                        DragView(id: UUID()) { dragInfo in
//                            Text(option)
//                                .padding()
//                                .background{
//                                    dragInfo.isDragging ? Color.blue : Color.mint
//                                }
//
//                        }
//                        .onDrag(<#T##data: () -> NSItemProvider##() -> NSItemProvider#>) { isSuccessful in
//                            if(isSuccessful){
//                                currSelected = option
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
////
struct DragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDropView()
    }
}

import SwiftUI
import UniformTypeIdentifiers

struct DragAndDropView: View, DropDelegate {
  @State private var textInput = ""
  @State private var items = ["Apple", "Orange", "Kiwi", "Pear"]
  @State private var dragInProgress = false

  var body: some View {
    VStack(alignment: .leading) {
      Text("New fruit")
        .onDrag {
          NSItemProvider(object: "New fruit" as NSString)
        } preview: {
          Label("Add new fruit!", systemImage: "applelogo")
        }

      Text("Fruit")
        .padding(.top, 30)
      HStack {
        ForEach(items, id: \.self) { fruit in
          Text(fruit)
        }
      }
      .background(dragInProgress ? Color.orange : nil)
      .onDrop(of: [UTType.plainText], delegate: self)
      Spacer()
    }
    .padding()
  }

  func dropEntered(info: DropInfo) {
    dragInProgress = info.hasItemsConforming(to: [UTType.plainText])
  }

  func dropExited(info: DropInfo) {
    dragInProgress = false
  }

  func performDrop(info: DropInfo) -> Bool {
    for item in info.itemProviders(for: [UTType.plainText]) {
      item.loadObject(ofClass: NSString.self) { item, error in
        if let str = item as? String {
          items.append(str)
        }
      }
    }
    dragInProgress = false
    return true
  }
}
