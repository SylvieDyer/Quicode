//
//  Questions.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//
import Foundation

public enum QuestionType {
    case multiSelect
    case multipleChoice
    case dragAndDrop
}

public class Question {
    let questionText: String
    let questionType: QuestionType
    let questionOptions: [String]
    
    init(_ questionText: String, _ questionType: QuestionType, _ questionOptions: [String]) {
        self.questionText = questionText
        self.questionType = questionType
        self.questionOptions = questionOptions
    }
}
