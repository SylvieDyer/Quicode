//
//  QuestionView.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 9/5/23.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    var body: some View {
        // z-stack of questions? maybe?
        Text("**\(question.questionText)**").font(.title2).fontWeight(.bold)
    }
}
