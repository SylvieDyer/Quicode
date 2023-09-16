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
    
    // to make values mutable
    @State var answer1 = "NULL"
    @State var answer2 = "NULL"
    
    var body: some View {
        InteractiveDragDropContainer{
            VStack{
                HStack{
                    
                    // TODO: issue with for loop rendering: catagorizes drop views w/ the same status......
                    
                    /* LOOP TO RENDER QUESTION AND BLANK DROPVIEWS : */
                    
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
                    
                    
                    // TODO: .onDragViewReceived doesn't properly update the answer fields
                    
                    /* HARD CODED RENDERING OF SENTENCE AND DROP VIEW */
                    Text("A")
                    DropView { dropInfo in
                        Text(dropInfo.didDrop ? answer1 : "BLANK")
                            .padding()
                            .background{
                                dropInfo.isColliding ? Color.purple : Color.gray
                            }
                    }
                    .onDragViewReceived { receivingViewID in
                        print(receivingViewID)
                        // TODO: doesn't update text
                        answer1 = receivingViewID.uuidString
                    }
                    Text("IS")
                    Text("A")
                    DropView { dropInfo in
                        Text(dropInfo.didDrop ? answer2 : "BLANK")
                            .padding()
                            .background{
                                dropInfo.isColliding ? Color.purple : Color.gray
                            }
                    }
                    .onDragViewReceived { receivingViewID in
                        answer2 = receivingViewID.uuidString
                    }
                }
                HStack{
                    ForEach(options, id: \.self) { option in
                        DragView(id: question.getID()) { dragInfo in
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
