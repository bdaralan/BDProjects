//
//  TextViewWrapperPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 5/1/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct TextViewWrapperPreview: View {
    
    @State private var text = "BDTextViewWrapper"
    @State private var isFirstResponder = true
    @State private var isEditable = true
    @State private var adjustOffset = true
    
    
    var body: some View {
        VStack {
            Toggle("First Responder", isOn: $isFirstResponder)
            
            Toggle("Editable", isOn: $isEditable)
            
            Toggle("Adjust Offset Automatically", isOn: $adjustOffset)
            
            VStack {
                Text("FOR INTERNAL USE ONLY")
                Text("see BDTextViewWrapper documentation")
            }
                .foregroundColor(.red)
            
            BDTextViewWrapper(
                text: $text,
                isFirstResponder: $isFirstResponder,
                isEditable: isEditable,
                adjustOffsetAutomatically: adjustOffset,
                configure: configureTextView
            )
                .frame(maxHeight: .infinity)
        }
        .padding(32)
    }
    
    func configureTextView(_ textView: UITextView) {
        textView.textColor = .purple
    }
}


struct TextViewWrapperPreview_Previews: PreviewProvider {
    static var previews: some View {
        TextViewWrapperPreview()
    }
}
