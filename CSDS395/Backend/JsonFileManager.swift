//
//  JsonFileManager.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/11/23.
//

import Foundation


func writeJson<T: Encodable>(destPath: String, data: T) {
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

import Foundation

func pullJson(from filePath: String) -> QuestionList? {
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
           let questionAnswer = questionData["questionAnswer"] as? [String] {
            
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
                question = MultipleQ(questionText: questionText, questionOptions: questionOptions, questionAnswer: questionAnswer)
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


    // Call pullJson for testing within the main function
    if let questionList = pullJson(from: "sample.json") {
        // Successfully parsed the JSON file into a QuestionList object.
        // You can now work with the questions using methods from the QuestionList class.
        // For example, you can print the first question's text:
        let firstQuestion = questionList.getCurrent()
        print("First question: \(firstQuestion.questionText)")
    } else {
        print("Failed to parse the JSON file.")
    }



