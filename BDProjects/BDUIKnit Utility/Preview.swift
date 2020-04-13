//
//  Preview.swift
//  BDUIKnitProject
//
//  Created by Dara Beng on 4/12/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI


enum Preview: String, CaseIterable {
    
    case BDButtonTrayView
    
    case BDModalTextField
    
    var content: some View {
        switch self {
        case .BDButtonTrayView: return AnyView(ButtonTrayViewPreview())
        case .BDModalTextField: return AnyView(ModalTextFieldPreview())
        }
    }
    
    var fullscreen: Bool {
        switch self {
        case .BDButtonTrayView: return true
        case .BDModalTextField: return false
        }
    }
}
