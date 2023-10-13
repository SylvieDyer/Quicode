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
    case blank
}

public enum QuestionDifficulty {
    case easy
    case medium
    case hard
}

protocol Question {
    var questionType: QuestionType { get }
    var questionText: String { get set }
    var questionOptions: [String] { get set }
    var questionAnswer: [String] { get set }
    var questionDifficulty: QuestionDifficulty { get set }
    var id: UUID { get }
}

public class MultipleQ: Question {
    var questionType: QuestionType
    var questionText: String
    var questionOptions: [String]
    var questionAnswer: [String]
    var questionDifficulty: QuestionDifficulty
    var id: UUID
    
    
    init(questionText: String, questionOptions: [String], questionAnswer:[String], questionDifficulty:QuestionDifficulty) {
        self.questionType = QuestionType.multiSelect
        self.questionText = questionText
        self.questionOptions = questionOptions
        self.questionAnswer = questionAnswer
        self.questionDifficulty = questionDifficulty
        self.id = UUID()
    }
    
    func getID() -> UUID {
        return self.id
    }
}

public class BlankQ: Question {
    var questionType: QuestionType
    var questionText: String = "UNSET"
    var questionOptions: [String] = []
    var questionAnswer: [String] = []
    var questionDifficulty: QuestionDifficulty = QuestionDifficulty.easy
    var id: UUID
    
    init() {
        self.questionType = QuestionType.blank
        self.id = UUID()
    }
    
    func getId() -> UUID {
        return self.id
    }
}

public class QuestionList {
    var currentPos: Int
    var qlist: [Question]
    
    init(qlist: [Question]) {
        self.currentPos = 0
        self.qlist = qlist
    }
    
    func getCurrent() -> Question? {
//        print("get current: " + String(currentPos))
        if(currentPos >= qlist.count) {
            return nil
        }
        return qlist[currentPos]
    }
    
    // Returns nil if at last question
    func getNext() -> Question? {
//        print(currentPos)
        currentPos += 1
        if (currentPos < qlist.count - 1) {
            return getCurrent()
        }
        return nil
    }
    
    func peekNext() -> Question? {
        return getQuestionAtIndex(index: currentPos + 1)
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
        return getQuestionAtIndex(index: currentPos - 1)
    }
    
    func isLast() -> Bool {
        return currentPos >= qlist.count - 1
    }
    
    func getQuestionAtIndex(index: Int) -> Question? {
        if (index < qlist.count && index >= 0) {
            return qlist[index]
        }
        return nil
    }
    
    func getRandomQuestion() -> Question? {
        return getQuestionAtIndex(index: Int.random(in: 0..<qlist.count))
    }
}
