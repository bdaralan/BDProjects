//
//  ModalTextViewPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 4/14/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct ModalTextViewPreview: View {
    
    @State private var textViewModel = BDModalTextViewModel()
    @State private var presentSheet = false
    @State private var presentWithKeyboard = true
    
    
    var body: some View {
        Form {
            Toggle("Present with Keyboard", isOn: $presentWithKeyboard)
            
            Toggle("Editable", isOn: $textViewModel.isEditable)
            
            Button("Random Title Color") {
                self.textViewModel.titleColor = .random()
            }
            .accentColor(textViewModel.titleColor ?? .primary)
            
            Section(header: Text("TEXT VIEW")) {
                Button(action: presentModalTextView) {
                    Text(textViewModel.text)
                        .padding(.vertical)
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $presentSheet) {
            BDModalTextView(viewModel: self.$textViewModel)
        }
    }
    
    func presentModalTextView() {
        textViewModel.title = "Title"
        
        textViewModel.onCommit = {
            self.textViewModel.isFirstResponder = false
            self.presentSheet = false
        }
        
        textViewModel.isFirstResponder = presentWithKeyboard
        presentSheet = true
    }
}


struct ModalTextViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        ModalTextViewPreview()
    }
}
