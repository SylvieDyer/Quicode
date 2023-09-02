//
//  AppController.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import Foundation
class AppController: NSObject, ObservableObject {
    var moduleNames: [String] = ["CS Foundations", "Basic Java", "Basic Python"]
}
extension AppController {
    struct Selection: Equatable{
        var foundataions = false
        var java = false
        var python = false
        
        mutating func openFoundations(){
            foundataions = true
        }
        mutating func openJava() {
            java = true
        }
        mutating func openPython() {
            python = true
        }
    }
}


