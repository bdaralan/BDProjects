//
//  PresentationItemPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 4/13/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct PresentationItemPreview: View {
    
    // conform to `BDPresentationSheetItem` or `Identifiable`
    enum Sheet: BDPresentationSheetItem {
        
        case purple
        
        case red
        
        var color: Color {
            switch self {
            case .purple: return .purple
            case .red: return .red
            }
        }
    }
    
    // Don't forget to set shouldStorePrevious to true
    // if want to keep the previous sheet
    @State private var sheet = BDPresentationItem<Sheet>()

    var currentSheet: String {
        sheet.current == nil ? "nil" : "\(sheet.current!)"
    }
    
    var previousSheet: String {
        sheet.previous == nil ? "nil" : "\(sheet.previous!)"
    }
    
    
    var body: some View {
        Form {
            Section {
                Text("Current Sheet: \(currentSheet)")
                    .foregroundColor(sheet.current?.color)
                
                Text("Previous Sheet: \(previousSheet)")
                    .foregroundColor(sheet.previous?.color)
            }
            
            Button("Present Purple Sheet") {
                self.sheet.current = .purple
            }
            .accentColor(.purple)
            
            Button("Present Red Sheet") {
                self.sheet.present(.red)
            }
            .accentColor(.red)
            
            Button("Reset Previous") {
                self.sheet.resetPrevious()
            }
            
            Button("Reset All") {
                self.sheet = .init()
            }
        }
        .onAppear(perform: setupOnAppear)
        .sheet(item: $sheet.current, onDismiss: handleSheetDismissed, content: presentationSheet)
    }
    
    func setupOnAppear() {
        sheet.shouldStorePrevious = true
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


struct PresentationItemPreview_Previews: PreviewProvider {
    static var previews: some View {
        PresentationItemPreview()
    }
}
