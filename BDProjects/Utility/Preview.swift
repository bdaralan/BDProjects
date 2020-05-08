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
}


enum UIKnitPreview: String, CaseIterable, Preview {
    
    case BDButtonTrayView
    
    case BDModalTextField
    
    case BDModalTextView
    
    case BDTextFieldWrapper
    
    case BDTextViewWrapper
    
    case BDUIViewWrapperSegmentControl
    
    case BDPersistPropertyWrapper
    
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
        case .BDUIViewWrapperSegmentControl: return AnyView(UIViewWrapperSegmentControlPreview())
        case .BDPersistPropertyWrapper: return AnyView(PersistPropertyWrapperPreview())
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
}
