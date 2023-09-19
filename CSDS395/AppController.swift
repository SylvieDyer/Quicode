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
    private var questions: [String: Question] = [
        "Data Types and Variables":
            Question("This is a Data Types and Variables multiSelect", QuestionType.multiSelect, ["Option 1", "Option 2", "Option 3", "Option 4"], ["Option 1"], Question("This is a Data Types and Variables multiSelect2", QuestionType.multiSelect, ["Option 5", "Option 6", "Option 7", "Option 8"], ["Option 5"], nil)),
        "Operators":
            Question("This is a Operators multiSelect", QuestionType.multiSelect, ["Option 1", "Option 2", "Option 3", "Option 4"], ["Option 2", "Option 3"], nil),
    ]
    
    func getQuestions(name: String) -> Question {
        return questions[name] ?? Question("Unset question", QuestionType.multiSelect, [], [])
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
}


