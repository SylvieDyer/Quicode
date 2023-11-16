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


public class Question: Hashable, Identifiable {
    var questionType: QuestionType
    var questionText: String
    var questionOptions: [String]
    var questionAnswer: [String]
    var questionDifficulty: QuestionDifficulty
    var isComplete: Bool
    public var id: String {
        return UUID().uuidString
    }
    var selected: [String]
    
    init(questionType: QuestionType, questionText: String, questionOptions: [String], questionAnswer: [String], questionDifficulty: QuestionDifficulty) {
        self.questionType = questionType
        self.questionText = questionText
        self.questionOptions = questionOptions
        self.questionAnswer = questionAnswer
        self.questionDifficulty = questionDifficulty
        self.isComplete = false
        if(questionType == QuestionType.dragAndDrop) {
            self.selected = [String](repeating: "", count: questionAnswer.count)
        } else {
            self.selected = []
        }
//        self.id = UUID()
    }
    
    func getQuestionTextArr() -> [String] {
        return self.questionText.components(separatedBy: ",")
    }
    
    public static func == (lhs: Question, rhs: Question) -> Bool {
       return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getID() -> String {
        return self.id
    }
    

}

public class QuestionList: Hashable{

    var currentPos: Int
    var qlist: [Question]
    var id: String {
        return UUID().uuidString
    }
    
    init(qlist: [Question]) {
        self.currentPos = 0
        self.qlist = qlist
       
    }
    public static func == (lhs: QuestionList, rhs: QuestionList) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
  
    func getCurrent() -> (Question)? {
//        print("get current: " + String(currentPos))
        if(currentPos >= qlist.count) {
            return nil
        }
        return qlist[currentPos]
    }
    
    // Returns nil if at last question
    func getNext() -> (Question)? {
//        print(currentPos)
        currentPos += 1
        if (currentPos < qlist.count - 1) {
            return getCurrent()
        }
        return nil
    }
    
    func peekNext() -> (Question)? {
        return getQuestionAtIndex(index: currentPos + 1)
    }
    
    // Returns nil if at first question
    func getLast() -> (Question)? {
        if (currentPos > 0) {
            currentPos -= 1
            return getCurrent()
        }
        return nil
    }
    
    // Returns nil if at first question
    func peekLast() -> (Question)? {
        return getQuestionAtIndex(index: currentPos - 1)
    }
    
    func isLast() -> Bool {
        return currentPos >= qlist.count - 1
    }
    
    func getQuestionAtIndex(index: Int) -> (Question)? {
        if (index < qlist.count && index >= 0) {
            return qlist[index]
        }
        return nil
    }
    
    func reset() {
        currentPos = -1
    }
    
    func getRandomQuestion() -> (Question)? {
        return getQuestionAtIndex(index: Int.random(in: 0..<qlist.count))
    }
}
