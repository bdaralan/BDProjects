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
    
    let previews = Preview.allCases.sorted(by: { $0.name < $1.name })
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: headerBDUIKnit, footer: footerBDUIKnit) {
                    ForEach(previews, id: \.name) { preview in
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
            .font(Font.system(.body, design: .monospaced))
            .padding(.top, 24)
    }
    
    var footerBDUIKnit: some View {
        Text("Some previews are presented in fullscreen to demo their use cases and take screenshots. Since previews are self-contained, a way to dismiss is not embedded. To dismiss the preview, invoke the App Switcher. 😅")
            .font(Font.system(.callout, design: .monospaced))
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
