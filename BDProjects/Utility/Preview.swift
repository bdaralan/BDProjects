//
//  Preview.swift
//  BDUIKnitProject
//
//  Created by Dara Beng on 4/12/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI


protocol Preview {
    
    var name: String { get }
    
    var content: AnyView { get }
    
    var fullscreen: Bool { get }
}


enum UIKnitPreview: String, CaseIterable, Preview {
    
    case BDButtonTrayView
    
    case BDModalTextField
    
    case BDModalTextView
    
    case BDTextFieldWrapper
    
    case BDTextViewWrapper
    
    var name: String {
        rawValue
    }
    
    var content: AnyView {
        switch self {
        case .BDButtonTrayView: return AnyView(ButtonTrayViewPreview())
        case .BDModalTextField: return AnyView(ModalTextFieldPreview())
        case .BDModalTextView: return AnyView(ModalTextViewPreview())
        case .BDTextFieldWrapper: return AnyView(TextFieldWrapperPreview())
        case .BDTextViewWrapper: return AnyView(TextViewWrapperPreview())
        }
    }
    
    var fullscreen: Bool {
        switch self {
        case .BDButtonTrayView: return true
        case .BDModalTextField: return false
        case .BDModalTextView: return false
        case .BDTextFieldWrapper: return false
        case .BDTextViewWrapper: return false
        }
    }
}


enum SwiftilityPreview: String, CaseIterable, Preview {
    
    case BDPresentationSheet
    
    var name: String {
        rawValue
    }
    
    var content: AnyView {
        switch self {
        case .BDPresentationSheet: return AnyView(PresentationSheetPreview())
        }
    }
    
    var fullscreen: Bool {
        switch self {
        case .BDPresentationSheet: return false
        }
    }
}
