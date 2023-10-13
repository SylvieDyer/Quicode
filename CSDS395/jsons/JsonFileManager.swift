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
    jsonEncoder.outputFormatting = .prettyPrinted
    var jsonData: Data

    do {
        jsonData = try jsonEncoder.encode(data)
        print(jsonData)
        try jsonData.write(to: fileURL)
        print(fileURL)
    } catch {
        print("Error encoding object to JSON: \(error)")
    }
    
}
