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
    
    static func pullJson(from filePath: String) -> QuestionList? {
        // Read the JSON data from the file
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            return nil
        }
        
        // Decode the JSON data into an array of dictionaries
        guard let jsonFile = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            return nil
        }
        
        // Initialize an empty array to hold Question objects
        var questionList: [Question] = []
        
        // Iterate through the JSON array and create Question objects
        for questionData in jsonFile {
            if let questionTypeRaw = questionData["questionType"] as? String,
               let questionText = questionData["questionText"] as? String,
               let questionOptions = questionData["questionOptions"] as? [String],
               let questionAnswer = questionData["questionAnswer"] as? [String],
               let questionDifficulty = QuestionDifficulty.easy {
                
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
                if questionType == .multiSelect {
                    question = MultipleQ(questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer, questionDifficulty: questionDifficulty)
                } else {
                    question = BlankQ()
                }
                
                questionList.append(question)
            }
        }
        
        // Create a QuestionList object with the parsed questions
        let questionListObject = QuestionList(qlist: questionList)
        
        return questionListObject
    }
}
