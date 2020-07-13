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
    
    @State private var itemAnimations: [BDButtonTrayItemAnimation] = [
        .pulse(), .rotation(), .tilt(anchor: .top)
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack {
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
                
                BDButtonTrayView(viewModel: trayViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(20)
            }
            .navigationBarTitle(navigationTitle)
            .onAppear(perform: setupTrayViewModel)
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
        BDButtonTrayItem(title: "", image: .system("plus")) { item in
            print("main item triggered")
        }
    }
    
    func createTrayItems() -> [BDButtonTrayItem] {
        let newFolder = BDButtonTrayItem(title: "New Folder", image: .system("folder.badge.plus")) { item in
            print(item.title)
        }
        
        let folder = BDButtonTrayItem(title: "Folders", image: .system("folder")) { item in
            print(item.title)
        }
        
        let sort = BDButtonTrayItem(title: "Sort", image: .system("arrow.up.arrow.down.circle")) { item in
            self.navigationTitle = "Subitems"
            self.trayViewModel.subitems = self.createTraySortBySubitems()
        }
        
        let photo = BDButtonTrayItem(title: "Example of Disabled Item", image: .asset("placeholder-image")) { item in
            print(item.title)
        }
        
        photo.disabled = true
        
        let circles = BDButtonTrayItem(title: "Independent Color", image: .system("circle.grid.hex")) { item in
            item.activeColor = .random()
        }
        
        circles.activeColor = .purple
        
        let animate = BDButtonTrayItem(title: "Play Animations", image: .system("play.circle")) { item in
            let animation = self.itemAnimations.removeFirst()
            self.itemAnimations.append(animation)
            
            item.animation = animation
            
            switch animation {
            case .pulse:
                item.title = "Pulse"
                item.image = .system("heart.circle")
                item.activeColor = .pink
            case .rotation:
                item.title = "Rotation"
                item.image = .system("arrow.2.circlepath.circle")
                item.activeColor = nil
            case .tilt:
                item.title = "Tilt"
                item.image = .system("bell")
                item.activeColor = .orange
            }
        }
        
        let lock = BDButtonTrayItem(title: "Lock Tray", image: .system("lock.circle")) { item in
            self.trayViewModel.locked.toggle()
            let locked = self.trayViewModel.locked
            item.image = .system(locked ? "lock.circle.fill" : "lock.circle")
            item.title = locked ? "Unlock Tray" : "Lock Tray"
        }
        
        return [newFolder, folder, sort, photo, circles, animate, lock]
    }
    
    func createTraySortBySubitems() -> [BDButtonTrayItem] {
        let sortByDate = BDButtonTrayItem(title: "Sort by Date", image: .system("clock")) { item in
            print(item.title)
        }
        
        let sortByName = BDButtonTrayItem(title: "Sort by Name", image: .system("textformat")) { item in
            print(item.title)
        }
        
        let sortByTag = BDButtonTrayItem(title: "Sort by Tag", image: .system("tag")) { item in
            print(item.title)
        }
        
        let sortByFileType = BDButtonTrayItem(title: "Sort by File Type", image: .system("doc")) { item in
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
