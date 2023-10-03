//
//  JsonFileManager.swift
//  CSDS395
//
//  Created by Tran Dac Nguyen Kim on 9/11/23.
//

import Foundation


//func writeJson(destPath: String, userData: User) {
//    // Create a JSONEncoder
//    let encoder = JSONEncoder()
//    print(URL(fileURLWithPath: FileManager.default.currentDirectoryPath))
//    do {
//        // Encode the UserData instance into JSON data
//        let jsonData = try encoder.encode(userData)
//        let userJSONURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(destPath)
//        print(userJSONURL)
//        
//        // Write the JSON data to the file
//        try jsonData.write(to: userJSONURL, options: .atomic)
//    } catch {
//        print("Error encoding UserData to JSON: \(error)")
//    }
//}
