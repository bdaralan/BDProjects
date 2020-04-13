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
    
    let previews = Preview.allCases.sorted(by: { $0.rawValue < $1.rawValue })
    
    let header = Text("PREVIEWS")
    
    let footer = Text("Open App Switcher to dismiss the preview.")
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: self.header.padding(.top, 24), footer: self.footer) {
                    ForEach(previews, id: \.rawValue) { preview in
                        Button(preview.rawValue) {
                            self.presenter.present(preview)
                        }
                        .accentColor(.primary)
                        .font(.system(.body, design: .monospaced))
                    }
                }
            }
            .navigationBarTitle("BDUIKnitProject Previews", displayMode: .inline)
            .overlay(presenter.opacity(0))
            .onReceive(appWillActive, perform: { active in
                guard !active else { return }
                self.presenter.dismissPreview()
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appWillActive: .init())
    }
}
