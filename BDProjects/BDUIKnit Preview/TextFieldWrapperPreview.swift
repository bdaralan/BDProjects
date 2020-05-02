//
//  TextFieldWrapperPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 4/24/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct TextFieldWrapperPreview: View {
    
    @State private var text = "BDTextFieldWrapper"
    @State private var placeholder = "Placeholder"
    @State private var isFirstResponder = true
    
    
    var body: some View {
        VStack {
            BDTextFieldWrapper(
                isActive: $isFirstResponder,
                text: $text,
                placeholder: placeholder,
                textColor: .systemPurple,
                placeholderColor: .systemOrange,
                onCommit: handleTextFieldCommit,
                configure: configureTextField
            )
                .frame(height: 40)
                .padding([.horizontal, .top])
            
            Divider()
            
            VStack {
                Text("FOR INTERNAL USE ONLY")
                Text("see BDTextFieldWrapper documentation")
            }
                .foregroundColor(.red)
                .padding(.top)

            Spacer()
        }
    }
    
    func handleTextFieldCommit() {
        isFirstResponder = false
    }
    
    func configureTextField(_ textField: UITextField) {
        textField.font = .preferredFont(forTextStyle: .body)
        textField.clearButtonMode = .always
    }
}


struct TextFieldWrapperPreview_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWrapperPreview()
    }
}
