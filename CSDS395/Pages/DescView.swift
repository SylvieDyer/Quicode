//
//  DescView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/5/23.
//

import SwiftUI

struct DescView: View {
    var controller: AppController
    var blockName: String
    
    var body: some View {
        ScrollView{
            Text("**\(blockName)**").font(.title2).fontWeight(.bold)
            Text("A Brief Overview:").font(.title3)
            Text("\(controller.getOverview(blockName: blockName))")
        }
    }                 
}

