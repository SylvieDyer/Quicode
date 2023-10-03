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

protocol Question {
    var questionText: String { get set }
    var questionOptions: [String] { get set }
    var questionAnswer: [String] { get set }
    var id: UUID { get }
}

public class MultipleQ: Question {
    var questionText: String
    var questionOptions: [String]
    var questionAnswer: [String]
    var id: UUID
    
    
    init(questionText: String, questionOptions: [String], questionAnswer:[String]) {
        self.questionText = questionText
        self.questionOptions = questionOptions
        self.questionAnswer = questionAnswer
        self.id = UUID()
    }
    
    func getID() -> UUID {
        return self.id
    }

}

public class QuestionList {
    var currentPos: Int = 0
    var qlist: [Question]
    
    init(qlist: [Question]) {
        self.qlist = qlist
    }
    
    func getCurrent() -> Question {
        return qlist[currentPos]
    }
    
    // Returns nil if at last question
    func getNext() -> Question? {
        if (currentPos < qlist.count - 1) {
            currentPos += 1
            return getCurrent()
        }
        return nil
    }
    
    // Returns nil if at first question
    func getLast() -> Question? {
        if (currentPos > 0) {
            currentPos -= 1
            return getCurrent()
        }
        return nil
    }
    
    // Returns nil if at first question
    func peekLast() -> Question? {
        if (currentPos > 0) {
            return qlist[currentPos - 1]
        }
        return nil
    }
    
    func isLast() -> Bool {
        return currentPos >= qlist.count - 1
    }
}
