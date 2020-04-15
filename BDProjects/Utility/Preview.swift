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
    
    var name: String {
        rawValue
    }
    
    var content: AnyView {
        switch self {
        case .BDButtonTrayView: return AnyView(ButtonTrayViewPreview())
        case .BDModalTextField: return AnyView(ModalTextFieldPreview())
        case .BDModalTextView: return AnyView(ModalTextViewPreview())
        }
    }
    
    var fullscreen: Bool {
        switch self {
        case .BDButtonTrayView: return true
        case .BDModalTextField: return false
        case .BDModalTextView: return false
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
