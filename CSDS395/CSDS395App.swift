//
//  CSDS395App.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI
import UIKit

import Foundation
import SotoS3

@main
struct CSDS395App: App {
    // for user defaults
    let userDataController = UserDataController.shared

    
    var body: some Scene {
        WindowGroup {
            MainView(appController: AppController())
                .environment(\.managedObjectContext, userDataController.container.viewContext)
        }
    }
}
