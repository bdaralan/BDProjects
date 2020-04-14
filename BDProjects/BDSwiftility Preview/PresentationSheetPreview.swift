//
//  PresentationSheetPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 4/13/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDSwiftility


struct PresentationSheetPreview: View {
    
    enum Sheet: Identifiable {
        
        var id: Self { self }
        
        case purple
        
        case red
        
        var color: Color {
            switch self {
            case .purple: return .purple
            case .red: return .red
            }
        }
    }
    
    @State private var sheet = BDPresentationSheet<Sheet>()

    var currentSheet: String {
        sheet.current == nil ? "nil" : "\(sheet.current!)"
    }
    
    var previousSheet: String {
        sheet.previous == nil ? "nil" : "\(sheet.previous!)"
    }
    
    
    var body: some View {
        Form {
            Text("Current Sheet: \(currentSheet)")
                .foregroundColor(sheet.current?.color)
            
            Text("Previous Sheet: \(previousSheet)")
                .foregroundColor(sheet.previous?.color)
            
            Button("Present Purple Sheet") {
                self.sheet.current = .purple
            }
            
            Button("Present Red Sheet") {
                self.sheet.present(.red)
            }
        }
        .sheet(item: $sheet.current, onDismiss: handleSheetDismissed, content: presentationSheet)
    }
    
    func presentationSheet(_ sheet: Sheet) -> some View {
        switch sheet {
        
        case .purple:
            return Color.purple.edgesIgnoringSafeArea(.all)
        
        case .red:
            return Color.red.edgesIgnoringSafeArea(.all)
        }
    }
    
    func handleSheetDismissed() {
        switch sheet.previous {
        
        case nil:
            print("probably won't happen")
        
        case .purple:
            print("that tasted purple")
        
        case .red:
            print("famous red")
        }
    }
}


struct PresentationSheet_Previews: PreviewProvider {
    static var previews: some View {
        PresentationSheetPreview()
    }
}