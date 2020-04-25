//
//  ModalTextFieldPreview.swift
//  BDUIKnitProject
//
//  Created by Dara Beng on 4/11/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct ModalTextFieldPreview: View {
    
    @State private var todo = Todo()
    
    @State private var textFieldModel = BDModalTextFieldModel()
    @State private var presentSheet = false
    @State private var presentWithKeyboard = true
    
    let colors: [String: UIColor] = [
        "Purple": .systemPurple,
        "Blue": .systemBlue,
        "Orange": .systemOrange
    ]
    
    
    var body: some View {
        Form {
            Button(action: presentModalTextField) {
                HStack {
                    Text("Show Text Field")
                    Spacer()
                    Text(todo.title)
                }
                .foregroundColor(.primary)
            }
            Toggle("Show Clear Button", isOn: $textFieldModel.showClearTokenIndicator)
            Toggle("Present with Keyboard", isOn: $presentWithKeyboard)
        }
        .sheet(isPresented: $presentSheet) {
            BDModalTextField(viewModel: self.$textFieldModel)
        }
    }
    
    func presentModalTextField() {
        textFieldModel.title = "Title"
        textFieldModel.prompt = "Prompt"
        textFieldModel.placeholder = "Placeholder"
        textFieldModel.tokens = colors.keys.map({ $0 })
        
        // assign the text to the text field's text before present
        textFieldModel.text = todo.title
        
        textFieldModel.onCancel = {
            // ignore to update and dismiss
            self.textFieldModel.isFirstResponder = false
            self.presentSheet = false
        }
        
        textFieldModel.onCommit = {
            // grab the text from the text field and dismiss
            self.todo.title = self.textFieldModel.text
            self.textFieldModel.isFirstResponder = false
            self.presentSheet = false
        }
        
        textFieldModel.onReturnKey = {
            // grab the text from the text field and dismiss
            self.todo.title = self.textFieldModel.text
            self.textFieldModel.isFirstResponder = false
            self.presentSheet = false
        }
        
        textFieldModel.onTokenSelected = {
            if self.textFieldModel.showClearTokenIndicator {
                let index = self.textFieldModel.tokens.firstIndex(of: $0)!
                self.textFieldModel.tokens.remove(at: index)
            } else {
                let color = self.colors[$0]!
                self.textFieldModel.tokenBackgroundColor = Color(color)
                self.textFieldModel.placeholderColor = color
                self.textFieldModel.titleColor = Color(color)
                self.textFieldModel.tokenColor = .white
            }
        }
        
        textFieldModel.configure = { textField in
            textField.autocapitalizationType = .none
        }
        
        textFieldModel.isFirstResponder = presentWithKeyboard
        presentSheet = true
    }
}


struct ModalTextFieldPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModalTextFieldPreview().colorScheme(.light)
            ModalTextFieldPreview().colorScheme(.dark)
        }
    }
}
