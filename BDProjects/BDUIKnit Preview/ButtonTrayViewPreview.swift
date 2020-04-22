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
    
    @State private var navigationTitle = "BDButtonTray"
    
    
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
            .navigationBarTitle(navigationTitle)
            .overlay(BDButtonTrayView(viewModel: trayViewModel).padding(20), alignment: .bottomTrailing)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: setupTrayViewModel)
    }
    
    func setupTrayViewModel() {
        trayViewModel.mainItem = createTrayMainItem()
        trayViewModel.items = createTrayItems()
        
        trayViewModel.onTrayWillExpand = { willExpand in
            if willExpand {
                self.navigationTitle = "Expanded"
            } else {
                self.navigationTitle = "BDButtonTray"
            }
        }
        
        trayViewModel.expanded = true
    }
    
    func createTrayMainItem() -> BDButtonTrayItem {
        BDButtonTrayItem(title: "", systemImage: "plus") { item in
            print("main item triggered")
        }
    }
    
    func createTrayItems() -> [BDButtonTrayItem] {
        let newFolder = BDButtonTrayItem(title: "New Folder", systemImage: "folder.badge.plus") { item in
            print(item.title)
        }
        
        let folder = BDButtonTrayItem(title: "Folders", systemImage: "folder") { item in
            print(item.title)
        }
        
        let sort = BDButtonTrayItem(title: "Sort", systemImage: "arrow.up.arrow.down.circle") { item in
            self.navigationTitle = "Subitems"
            self.trayViewModel.subitems = self.createTraySortBySubitems()
        }
        
        let photo = BDButtonTrayItem(title: "Example of Disabled Item", systemImage: "photo.on.rectangle") { item in
            print(item.title)
        }
        
        photo.disabled = true
        
        let circles = BDButtonTrayItem(title: "Independent Color", systemImage: "circle.grid.hex") { item in
            item.activeColor = .random()
        }
        
        circles.activeColor = .purple
        
        let eyeDropper = BDButtonTrayItem(title: "Example of applyChanges()", systemImage: "eyedropper") { item in
            let randomColor = Color.random()
            self.trayViewModel.itemActiveColor = randomColor
            self.trayViewModel.subitemActiveColor = randomColor
            self.trayViewModel.mainItem.activeColor = randomColor
            self.trayViewModel.applyChanges()
        }
        
        return [newFolder, folder, sort, photo, circles, eyeDropper]
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
            ButtonTrayViewPreview().environment(\.colorScheme, .light)
            
            ButtonTrayViewPreview().environment(\.colorScheme, .dark)
            
            ButtonTrayViewPreview()
                .previewDisplayName("Vertical Compact Layout")
                .previewLayout(PreviewLayout.fixed(width: 600, height: 500))
                .environment(\.verticalSizeClass, .compact)
            
            ButtonTrayViewPreview()
                .previewDisplayName("Right to Left Layout")
                .environment(\.layoutDirection, .rightToLeft)
            
            ButtonTrayViewPreview()
                .previewDisplayName("RL Vertical Compact Layout")
                .previewLayout(PreviewLayout.fixed(width: 600, height: 500))
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.verticalSizeClass, .compact)
        }
    }
}
