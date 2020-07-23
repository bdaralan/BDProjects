//
//  PersistPropertyWrapperPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 5/8/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct PersistPropertyWrapperPreview: View {
    
    static let nUsernameDidChange = Notification.Name("nUsernameDidChange")
    static let nProfileImageUrlDidChange = Notification.Name("nProfileImageUrlDidChange")
    
    // Note: Use string as keys or BDPersistKey for type-safe keys.
    enum Keys: BDPersistKey {
        var prefix: String { "some.prefix." }
        case username
        case profileImageUrl
    }
    
    @BDPersist(in: .userDefaults, key: Keys.username, default: "", post: nUsernameDidChange)
    var username: String
    
    @BDPersist(in: .userDefaults, key: Keys.profileImageUrl, default: nil, post: nProfileImageUrlDidChange)
    var profileImageUrl: String?
    
    let usernameNotification = NotificationCenter.default.publisher(for: nUsernameDidChange)
    let profileImageNotification = NotificationCenter.default.publisher(for: nProfileImageUrlDidChange)
    
    
    var body: some View {
        Form {
            Section(header: Text("NON-OPTIONAL VALUE")) {
                Text("Username: \(username)")
                Button("Update Username") {
                    let number = Int.random(in: 1...1000)
                    self.username = "User #\(number)"
                }
            }
            
            Section(header: Text("OPTIONAL VALUE")) {
                Text("Profile Image URL: \(profileImageUrl ?? "nil")")
                Button("Update URL") {
                    let number = Int.random(in: 1...1000)
                    let isNilUrl = number.isMultiple(of: 5)
                    self.profileImageUrl = isNilUrl ? nil : "https://image.url/\(number)"
                }
            }
        }
        .onReceive(usernameNotification) { notification in
            let username = notification.object as? String ?? "nil"
            print("onReceive username notification: \(username)")
        }
        .onReceive(profileImageNotification) { notification in
            let url = notification.object as? String ?? "nil"
            print("onReceive profile image notification: \(url)")
        }
    }
}


struct PersistPropertyWrapperPreview_Previews: PreviewProvider {
    static var previews: some View {
        PersistPropertyWrapperPreview()
    }
}
