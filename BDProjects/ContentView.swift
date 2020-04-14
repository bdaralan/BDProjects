//
//  ContentView.swift
//  BDProjects
//
//  Created by Dara Beng on 4/13/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    var appWillActive: PassthroughSubject<Bool, Never>
    
    let presenter = PreviewPresenter()
    
    let allUIKnitPreviews = UIKnitPreview.allCases.sorted(by: { $0.name < $1.name })
    
    let allSwiftilityPreviews = SwiftilityPreview.allCases.sorted(by: { $0.name < $1.name })
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    messageText
                }
                
                Section(header: headerBDUIKnit) {
                    ForEach(allUIKnitPreviews, id: \.name) { preview in
                        Button(preview.name) {
                            self.presenter.present(preview)
                        }
                        .accentColor(.primary)
                        .font(.system(.body, design: .monospaced))
                    }
                }
                
                Section(header: headerBDSwiftility) {
                    ForEach(allSwiftilityPreviews, id: \.name) { preview in
                        Button(preview.name) {
                            self.presenter.present(preview)
                        }
                        .accentColor(.primary)
                        .font(.system(.body, design: .monospaced))
                    }
                }
            }
            .navigationBarTitle("BDProjects", displayMode: .inline)
            .overlay(presenter.opacity(0))
            .onReceive(appWillActive, perform: handleAppWillActive)
        }
    }
}


extension ContentView {
    
    var headerBDUIKnit: some View {
        Text("BDUIKnit Previews")
            .font(.system(.body, design: .monospaced))
    }
    
    var headerBDSwiftility: some View {
        Text("BDSwiftility Previews")
            .font(.system(.body, design: .monospaced))
    }
    
    var messageText: some View {
        Text("Some previews are presented in fullscreen to demo their use cases and take screenshots. Since previews are self-contained view, a way to dismiss is not implenented. To dismiss fullscreen preview, invoke the App Switcher. 😅")
            .font(Font.system(.callout, design: .monospaced))
            .padding(.vertical)
            .multilineTextAlignment(.center)
    }
    
    func handleAppWillActive(_ active: Bool) {
        guard !active else { return }
        presenter.dismissPreview()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appWillActive: .init())
    }
}
