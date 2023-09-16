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
    let questionAnswer: [String]
    let nextQuestion: Question? //LinkedList type structure
    
    init(_ questionText: String, _ questionType: QuestionType, _ questionOptions: [String], _ questionAnswer:[String], _ nextQuestion: Question?) {
        self.questionText = questionText
        self.questionType = questionType
        self.questionOptions = questionOptions
        self.questionAnswer = questionAnswer
        self.nextQuestion = nextQuestion
    }
}
