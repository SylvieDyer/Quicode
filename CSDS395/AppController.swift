//
//  AppController.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import Foundation
class AppController: NSObject, ObservableObject {

    private var moduleNames: [String] = []
    private var blockNames : [String : Any] = [:]
    private var blockContent : [String:Any] = [:]
    private var questions: [String: QuestionList?] = [:]
    
    @Published var viewController = ViewController()
    
    func setAppInfo(awsManager: AWSManager) async {
        /// module and block names
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
                print("MoudleNames NOT IN JSON FORMAT")
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
            
            // TODO: edit JSON to remove leading space
            var list = module.values.description
            // remove the [] situation
            list.popLast()
            list.removeFirst()
            blockNames.updateValue(list.components(separatedBy: CharacterSet(charactersIn: ",;")), forKey: module.keys.first ?? "ERROR")
        }
        
        /// brief overviews
        print("getting overview:")
        
        // contents of the s3 object as a string
        let content = await awsManager.getFile(fileName: "blockOverviews.json")
        
        // convert String into Data
        let overviews = content.data(using: .utf8)!
        
        // parse into jsonArray (with type [Dictionary<String,Any>])
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: overviews, options : .allowFragments) as? [Dictionary<String,Any>]
            {
//                print(jsonArray) // use the json here
                dict = jsonArray
                
            } else {
                print("BlockOverviews NOT IN JSON FORMAT")
            }
        } catch let error as NSError {
            print(error)
        }
        
        
        for block in dict {
           
            var briefOverview = block.values.description
            // remove the [] situation
            briefOverview.popLast()
            briefOverview.removeFirst()
            blockContent.updateValue(briefOverview, forKey: block.keys.first ?? "ERROR")
        }
        
        /// questions
        questions = await [
            "Data Types and Variables": JsonFileManager.pullJson(fromS3: "dataTypes.json"),
            " Operators": JsonFileManager.pullJson(fromS3: "operators.json"),
            " Boolean Expressions": JsonFileManager.pullJson(fromS3: "booleanExpressions.json")
        ]
        
    }
    
    func getModuleNames() -> [String] {
        return moduleNames
    }
    
    func getBlocks(name: String) -> [String]{
        print(name)
        return blockNames[name] as! [String]
    }
        
    func getQuestions(name: String) -> QuestionList {
        return (questions[name] ?? QuestionList(qlist: []))! 
    }
    
    func getOverview(blockName: String) -> String {
        return blockContent[blockName] as! String
    }
}


extension AppController {
    
    struct ViewController: Equatable {
        var logInPage = true
        var homePage = false
        var userPage = false
        
        mutating func setAsHome() {
            userPage = false
            homePage = true
            logInPage = false
        }
        
        mutating func setAsUser() {
            homePage = false
            userPage = true
            logInPage = false
        }
        
        mutating func setAsLogIn(){
            logInPage = true
            homePage = false
            userPage = false
        }
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


