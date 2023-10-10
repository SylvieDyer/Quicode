//
//  AppController.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import Foundation
class AppController: NSObject, ObservableObject {
    // TODO: HARDCODED- Connect to DB
    private var moduleNames: [String] = []
    private var blockNames : [String : Any] = [:]
    
    func setAppInfo(awsManager: AWSManager) async {
        var dict = [Dictionary<String, Any>]()      // set a dict for the values retrieved from JSON
        
        // contents of the s3 object as a string
        let string = await awsManager.getFile(fileName: "ModuleNames.json")
        
        // convert String into Data
        let data = string.data(using: .utf8)!
        
        // parse into jsonArray (with type [Dictionary<String,Any>])
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                print(jsonArray) // use the json here
                dict = jsonArray
                
            } else {
                print("FILE NOT IN JSON FORMAT")
            }
        } catch let error as NSError {
            print(error)
        }
        
        
        // set the moduleNames AND blocks for each module
        for module in dict {
            /// for syntax reference:
            // module --> ["moduleName": <block list>]
            // module.keys --> ["moduleName"]
         
            // add module names to module name list
            moduleNames.append(module.keys.first ?? "Coming Soon") // workaround for null values
                      
            // add [moduleName, [block names]] to info -- TODO: extra [ and ] at the end due to split... will need to fix
            blockNames.updateValue(module.values.description.components(separatedBy: CharacterSet(charactersIn: ",;")), forKey: module.keys.first ?? "ERROR")
        }
    }
    
    func getModuleNames() -> [String] {
        return moduleNames
    }
    
    func getBlocks(name: String) -> [String]{
        return blockNames[name] as! [String]
    }
    
    
    //TODO: HARDCODED - Connect to DB
    
    private var questions: [String: QuestionList] = [
        "Data Types and Variables": QuestionList(qlist: [MultipleQ(questionText: "This is a Data Types and Variables multiSelect",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 1"], questionDifficulty: QuestionDifficulty.easy), MultipleQ(questionText: "This is a Data Types and Variables multiSelect2",  questionOptions: ["Option 5", "Option 6", "Option 7", "Option 8"], questionAnswer: ["Option 7"], questionDifficulty: QuestionDifficulty.medium), MultipleQ(questionText: "This is a Data Types and Variables multiSelect3",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 2", "Option 3"], questionDifficulty: QuestionDifficulty.hard)]),
        "Operators": QuestionList(qlist: [MultipleQ(questionText: "This is an Operators multiSelect",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 1"], questionDifficulty: QuestionDifficulty.easy)])
    ]
    
    func getQuestions(name: String) -> QuestionList {
        return questions[name] ?? QuestionList(qlist:[BlankQ()])
    }
}
extension AppController {
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


