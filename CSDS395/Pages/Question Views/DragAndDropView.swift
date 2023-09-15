//
//  DragAndDropView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/15/23.
//

import SwiftUI
import DragAndDrop

struct DragAndDropView: View {

    
    var question: Question
    
    let questionTemp = ["A", "BLANK", "IS", "A", "BLANK"];
    let answers = ["Integer", "Type"]
    let options = ["Variable", "Cow", "Type", "Pencil", "Integer"]
    let answerIDs = [UUID(), UUID()]
    
    var body: some View {
        InteractiveDragDropContainer{
            VStack{
                HStack{
                    // TODO: issue with for loop rendering: catagorizes drop views w/ the same status......
                   
//                    ForEach(questionTemp, id: \.self) { word in
//                        if (word == "BLANK"){
//                            DropView { dropInfo in
//                                Text(dropInfo.didDrop ? "DROPPED" : "BLANK")
//                                               .padding()
//                                               .background{
//                                                   dropInfo.isColliding ? Color.green : Color.red
//                                               }
//                                       }
//                                       .onDragViewReceived { receivingViewID in
//                                           Text(receivingViewID.uuidString)
//                                       }
//                        }
//                        else {
//                            Text(word)
//                        }
//                    }
                    
                    // TODO: droppedInfo.did drop - can't tell WHAT was dropped there
                    
                    Text("A")
                    
                    DropView { dropInfo in
                                   Text(dropInfo.didDrop ? "Dropped" : "BLANK")
                                       .padding()
                                       .background{
                                           dropInfo.isColliding ? Color.purple : Color.gray
                                       }
                               }
                               .onDragViewReceived { receivingViewID in
                                   print(receivingViewID)
                               }
                    Text("IS")
                    Text("A")
                    DropView { dropInfo in
                                   Text(dropInfo.didDrop ? "Dropped" : "BLANK")
                                       .padding()
                                       .background{
                                           dropInfo.isColliding ? Color.purple : Color.gray
                                       }
                               }
                               .onDragViewReceived { receivingViewID in
                                   print(receivingViewID)
                               }
                }
                HStack{
                    ForEach(options, id: \.self) { option in
                        DragView(id: UUID()) { dragInfo in
                            Text(option)
                                .padding()
                                .background{
                                    dragInfo.isDragging ? Color.blue : Color.mint
                                }
                        }
                        
                    }
                }
            }
        }
    }
}

struct DragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDropView(question: Question("h", QuestionType.dragAndDrop, ["h"]))
    }
}
