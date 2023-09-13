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
        switch question.questionType {
        case QuestionType.multiSelect:
            MultipleQView(question: question)
        case QuestionType.multipleChoice:
            MultipleQView(question: question)
        default:
            Text("**\(question.questionText)**").font(.title2).fontWeight(.bold)
        }
    }
}
