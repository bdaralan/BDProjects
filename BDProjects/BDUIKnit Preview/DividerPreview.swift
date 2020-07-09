//
//  Divider.swift
//  BDProjects
//
//  Created by Dara Beng on 7/9/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct DividerPreview: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            BDDivider(title: "Section 1")
            
            Text("section 1 content")
            
            BDDivider(title: "Section 2", titleColor: .blue)
            Text("section 2 content")
            
            BDDivider(title: "Section 3",lineColor: .blue)
            Text("section 3 content")
        }
        .padding(.horizontal)
    }
}


struct DividerPreview_Previews: PreviewProvider {
    static var previews: some View {
        DividerPreview()
    }
}
