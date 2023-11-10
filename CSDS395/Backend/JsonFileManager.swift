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
    
    
    static func pullJson(fromS3 fileName: String) async -> QuestionList? {
        
        let awsManager = AWSManager()
    
        // Get the JSON content from AWS S3 using the getFile function
        guard let jsonContent = try? await awsManager.getFile(fileName: fileName) else {
            print("Unable to fetch JSON content from S3.")
            return nil
        }
        // Convert the JSON string to Data
        guard let jsonData = jsonContent.data(using: .utf8) else {
            print("Unable to convert JSON content to data.")
            return nil
        }
        
        // Decode the JSON data into an array of dictionaries
        guard let jsonFile = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: [String: Any]] else {
            print("Unable to deserialize JSON content.")
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
                
                // Create the question object
                let question: Question
                question = Question(questionType: questionType, questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer, questionDifficulty: QuestionDifficulty.easy)
                
                questionList.append(question)
            }
        }
        
        // Create a QuestionList object with the parsed questions
        let questionListObject = QuestionList(qlist: questionList)
        return questionListObject
        
        }
}
