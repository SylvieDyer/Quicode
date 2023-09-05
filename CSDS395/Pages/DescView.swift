//
//  DescView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/5/23.
//

import SwiftUI

struct DescView: View {
    let name: String
    var body: some View {
        Text("**\(name)**").font(.title2).fontWeight(.bold)
        Text("A Brief Overview:").font(.title3)
    }
}

