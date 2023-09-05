//
//  ModuleView.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/2/23.
//

import SwiftUI

// template for module pages 
struct ModuleView: View {
    let name: String
    let blocks: [String]
    var body: some View {
        Text(name).foregroundColor(.indigo.opacity(0.7)).font(.title2).fontWeight(.heavy)
           
        List{
            // iterate through list of blocks
            ForEach(blocks, id: \.self) { blockName in
                // individual module
                NavigationLink(blockName){
                    
                }
                .foregroundColor(.indigo.opacity(0.7)).font(.title3).fontWeight(.heavy)
                .padding([.bottom], 50)
            }
        }
    }
}


