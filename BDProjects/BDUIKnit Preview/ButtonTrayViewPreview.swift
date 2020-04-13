//
//  ButtonTrayViewPreview.swift
//  BDUIKnitProject
//
//  Created by Dara Beng on 4/8/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct ButtonTrayViewPreview: View {
    
    let trayViewModel = BDButtonTrayViewModel()
    
    @State private var navigationTitle: String?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 16) {
                    ForEach(0..<9) { number in
                        Rectangle()
                            .fill(Color(UIColor.tertiarySystemFill))
                            .frame(height: 150)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .navigationBarTitle(navigationTitle ?? "BDButtonTray")
            .overlay(BDButtonTrayView(viewModel: trayViewModel).padding(20), alignment: .bottomTrailing)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: setupOnAppear)
        .onReceive(trayViewModel.$subitems, perform: { items in
            self.navigationTitle = items.isEmpty ? nil : "Subitems"
        })
    }
    
    func setupOnAppear() {
        trayViewModel.items = createTrayItems()
        
        trayViewModel.action = {
            print("main button triggered")
        }
        
        trayViewModel.onTrayWillExpand = { willExpand in
            self.navigationTitle = willExpand ? "Expanded" : nil
        }
        
        trayViewModel.buttonSystemImage = "plus"
        trayViewModel.expanded = true
    }
    
    func createTrayItems() -> [BDButtonTrayItem] {
        let newFolder = BDButtonTrayItem(title: "New Folder", systemImage: "folder.badge.plus") { item in
            print(item.title)
        }
        
        let folder = BDButtonTrayItem(title: "Folders", systemImage: "folder") { item in
            print(item.title)
        }
        
        let sort = BDButtonTrayItem(title: "Sort", systemImage: "arrow.up.arrow.down.circle") { item in
            self.trayViewModel.subitems = self.createTraySortBySubitems()
            self.navigationTitle = "Subitems"
        }
        
        let photo = BDButtonTrayItem(title: "Example of Disabled Item", systemImage: "photo.on.rectangle") { item in
            print(item.title)
        }
        
        photo.disabled = true
        
        let eyeDropper = BDButtonTrayItem(title: "Example of applyChanges()", systemImage: "eyedropper") { item in
            self.trayViewModel.itemActiveColor = .random()
            self.trayViewModel.subitemActiveColor = .random()
            self.trayViewModel.buttonActiveColor = .random()
            self.trayViewModel.applyChanges()
        }
        
        return [newFolder, folder, sort, photo, eyeDropper]
    }
    
    func createTraySortBySubitems() -> [BDButtonTrayItem] {
        let sortByDate = BDButtonTrayItem(title: "Sort by Date", systemImage: "clock") { item in
            print(item.title)
        }
        
        let sortByName = BDButtonTrayItem(title: "Sort by Name", systemImage: "textformat") { item in
            print(item.title)
        }
        
        let sortByTag = BDButtonTrayItem(title: "Sort by Tag", systemImage: "tag") { item in
            print(item.title)
        }
        
        let sortByFileType = BDButtonTrayItem(title: "Sort by File Type", systemImage: "doc") { item in
            print(item.title)
        }
        
        return [sortByDate, sortByName, sortByTag, sortByFileType]
    }
}


struct ButtonTrayViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonTrayViewPreview().colorScheme(.light)
            ButtonTrayViewPreview().colorScheme(.dark)
            ButtonTrayViewPreview().environment(\.layoutDirection, .rightToLeft)
            ButtonTrayViewPreview().environment(\.verticalSizeClass, .compact)
        }
    }
}
