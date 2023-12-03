//
//  ProgressUtils.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 12/2/23.
//

import Foundation

struct ProgressUtils {
    @available(*, unavailable) private init() {}
    static private let lessonToInt : [String : Int] = [
        "CS Foundations" : 100,
        "Java Basics" : 200,
        "Data Structures" : 300,
        "Python Basics" : 400,
        "Data Types and Variables" : 110,
        "Operators" : 120,
        "Conditionals" : 130,
        "Arrays" : 140,
        "Iteration" : 150,
        "Data Types in Java" : 210,
        "Operators in Java": 220,
        "Conditionals in Java" : 230,
        "Arrays in Java" : 240,
        "Iteration in Java" : 250,
        "Dictionaries" : 310,
        "Linked Lists" : 320,
        "Queues" : 330,
        "Stacks" : 340,
        "Sets" : 350,
        "Trees" : 360,
        "BLOCK 1" : 410,
        "BLOCK 2": 420,
        "easy" : 1,
        "medium" : 2,
        "hard" : 3
    ]
    
    static func isLastBlock(blockVal: Int) -> Bool {
        return blockVal == 150 || blockVal == 250 || blockVal == 360 || blockVal == 420
    }
    
    static func isFirstBlock(blockVal: Int) -> Bool {
        return blockVal == 110 || blockVal == 210 || blockVal == 310 || blockVal == 410
    }
        
    static func getKey(inputValue : Int) -> [String : String]{
        var outputDict : [String : String] = [:]
        let blockVal = (inputValue/10) * 10
        let moduleVal = (inputValue/100) * 100
        let difficulty = (inputValue % 10)
        for (key, value) in lessonToInt {
            if(value == blockVal) {
                outputDict["blockName"] = key
            }
            else if (value == moduleVal){
                outputDict["moduleName"] = key
            }
            else if (value == difficulty){
                outputDict["questionDifficulty"] = key
            }
        }
        return outputDict
    }
    
    static func getValue(inputValue : [String]) -> Int{
        var outputVal = 0
        for string in inputValue {
            outputVal += lessonToInt[string] ?? 0
        }
        return outputVal;
    }
}
