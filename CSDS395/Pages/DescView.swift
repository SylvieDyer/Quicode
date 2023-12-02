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
    var colorManager = ColorManager()
    
    var body: some View {
        ZStack{
            colorManager.getLightGreen().ignoresSafeArea(.all, edges: .all)
            ScrollView{
                Text("**\(blockName)**").font(.title2).fontWeight(.bold)
                Text("A Brief Overview:").font(.title3)
                Spacer()
                Text("\(controller.getOverview(blockName: blockName))")
            }.padding([.top, .leading, .trailing], 20)
        }
    }
}

