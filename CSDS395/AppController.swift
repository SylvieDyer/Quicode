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
                      
            // add [moduleName, [block names]] to info -- TODO: [] (JSON Format maybe?)
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
    
    private var questions: [String: QuestionList?] = [
        "[Data Types and Variables": JsonFileManager.pullJson(forResource: "sample", withExtension: "json"),
        " Operators": QuestionList(qlist: [MultipleQ(questionText: "This is an Operators multiSelect",  questionOptions: ["Option 1", "Option 2", "Option 3", "Option 4"], questionAnswer: ["Option 1"], questionDifficulty: QuestionDifficulty.easy)])
    ]
    
    func getQuestions(name: String) -> QuestionList {
        return (questions[name] ?? QuestionList(qlist: [BlankQ()])) ?? QuestionList(qlist: [])
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
    
//    static func start() {
//            // Call pullJson for testing
//            if let questionList = pullJson(from: "sample.json") {
//                // Successfully parsed the JSON file into a QuestionList object.
//                // You can now work with the questions using methods from the QuestionList class.
//                // For example, you can print the first question's text:
//                let firstQuestion = questionList.getCurrent()
//                print("First question: \(firstQuestion.questionText)")
//            } else {
//                print("Failed to parse the JSON file.")
//            }
//        }
}


