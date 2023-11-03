//
//  JsonFileManager.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/11/23.
//

import Foundation

struct JsonFileManager{
    
    
    static func writeJson<T: Encodable>(destPath: String, data: T) {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let fileURL = temporaryDirectory.appendingPathComponent(destPath)
        print(temporaryDirectory)
        
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted // For nicely formatted JSON
        var jsonData: Data?
        
        do {
            jsonData = try jsonEncoder.encode(data)
            try jsonData!.write(to: fileURL)
        } catch {
            print("Error encoding object to JSON: \(error)")
        }
    }
    
    
    static func pullJson(forResource: String, withExtension: String) -> QuestionList? {
//        if let fileURL = Bundle.main.url(forResource: "sample", withExtension: "json", subdirectory: "jsonsFiles") {
//        } else {
//            print("JSON file not found.")
//            return nil
//        }
        guard let fileURL = Bundle.main.url(forResource: forResource, withExtension: withExtension, subdirectory: "jsonsFiles") else {
            return nil
        }
        // Read the JSON data from the file
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        print(data)
        
        // Decode the JSON data into an array of dictionaries
        guard let jsonFile = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]] else {
            print("not deserialized!")
            return nil
        }
        // Initialize an empty array to hold Question objects
        var questionList: [Question] = []
        
        // Iterate through the JSON array and create Question objects
        for (key, value) in jsonFile {
            print(key) // This will print the topic name
            if let questionData = value as? [String: Any],
               let questionTypeRaw = questionData["questionType"] as? String,
               let questionText = questionData["questionText"] as? String,
               let questionOptions = questionData["questionOptions"] as? [String],
               let questionAnswer = questionData["questionAnswer"] as? [String] {

                // Rest of your code for processing question data
                let questionType: QuestionType
                switch questionTypeRaw {
                    case "multiSelect":
                        questionType = .multiSelect
                    case "multipleChoice":
                        questionType = .multipleChoice
                    case "dragAndDrop":
                        questionType = .dragAndDrop
                    default:
                        questionType = .blank
                }
                
                let question: Question
                question = Question(questionType: questionType, questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer, questionDifficulty: QuestionDifficulty.easy)
//                if questionType == .multiSelect {
//                    question = Question(questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer, questionDifficulty: QuestionDifficulty.easy)
//                } else if questionType == .dragAndDrop {
//                    question = DragAndDropQ(questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer, questionDifficulty: QuestionDifficulty.easy)
//                } else {
//                    question = BlankQ()
//                }

                questionList.append(question)
            }
        }
        
        // Create a QuestionList object with the parsed questions
        let questionListObject = QuestionList(qlist: questionList)
        
        return questionListObject
    }
}
