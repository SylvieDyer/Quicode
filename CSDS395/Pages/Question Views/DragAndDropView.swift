//
//  DragAndDropView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/15/23.
//

import SwiftUI
import DragAndDrop

struct DragAndDropView: View {
    
    //    var question: Question
    // PLACE HOLDER FOR QUESTION
    let questionText = ["A", "BLANK1", "IS", "A", "BLANK4"]
    let questionAnswers = ["Integer", "Type"]
    let questionOptions = ["Variable", "Cow", "Type", "Pencil", "Integer"]
    
    var body: some View {
        InteractiveDragDropContainer{
            VStack{
                HStack{
                    ForEach(Array(questionText.enumerated()), id: \.offset) { index, word in
                        if (word == "BLANK" + String(index)){
                            DropView { dropInfo in
                                Text(dropInfo.didDrop ? "DROPPED" : "BLANK")
                                    .padding()
                                    .background{
                                        dropInfo.isColliding ? Color.green : Color.red
                                    }
                            }
                            .onDragViewReceived { receivingViewID in
                                Text(receivingViewID.uuidString)
                            }
                        }
                        else {
                            Text(word)
                        }
                    }
                }
                HStack{
                    ForEach(questionOptions, id: \.self) { option in
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
        DragAndDropView()
    }
}
