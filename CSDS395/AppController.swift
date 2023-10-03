//
//  AppController.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import Foundation
class AppController: NSObject, ObservableObject {
    // TODO: HARDCODED- Connect to DB
    private var moduleNames: [String] = ["CS Foundations", "Basic Java", "Basic Python"]
    
    func getModuleNames() -> [String] {
        return moduleNames
    }
    
    //TODO: HARDCODED - Connect to DB
    
    private var questions: [String: QuestionList] = [
        "Data Types and Variables": QuestionList(qlist: [MultipleQ(questionText: "This is a Data Types and Variables multiSelect",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 1"]), MultipleQ(questionText: "This is a Data Types and Variables multiSelect2",  questionOptions: ["Option 5", "Option 6", "Option 7", "Option 8"], questionAnswer: ["Option 7"]), MultipleQ(questionText: "This is a Data Types and Variables multiSelect3",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 2", "Option 3"])]),
        "Operators": QuestionList(qlist: [MultipleQ(questionText: "This is an Operators multiSelect",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 1"])])
    ]
    
    func getQuestions(name: String) -> QuestionList {
        return questions[name] ?? QuestionList(qlist:[BlankQ()])
    }
    
    func getBlocks(name: String) -> [String] {
        switch name {
            
        case "CS Foundations":
            // TODO: HARDCODED - Connect to DB
            return ["Data Types and Variables", "Operators", "Boolean Expressions", "Conditionals", "Sequences", "Iteration"]

        default:
            return ["NO BLOCKS FOUND"]
        }
    }
}
extension AppController {
    // sample struct - does nothing for now but for syntax reference:
    struct Selection: Equatable{
        var foundataions = false
        var java = false
        var python = false
    }
    
    /// PLACE HOLDER FOR DND FUNCTIONALITY
    class DND: ObservableObject{
        var map : [String: UUID] = [:]
        
        func setVal(word: String, id: UUID){
            self.map[word] = id
        }
        
        func getWord(word:String) -> UUID {
            return self.map[word]!
        }
    }
}


