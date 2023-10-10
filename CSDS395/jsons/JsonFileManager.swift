//
//  JsonFileManager.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/11/23.
//

import Foundation


func writeJson(destPath: String, data: Users) {
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
        print("Error encoding Users object to JSON: \(error)")
    }
}
