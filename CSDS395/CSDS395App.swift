//
//  CSDS395App.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI

@main
struct CSDS395App: App {

    var body: some Scene {
        WindowGroup {
         HomeView(controller: AppController())
        }
    }
}
