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
    
    // For the purposes of this sample code, static is used on @BDPersist
    // so that they can be modified in View object.
    //
    // Usually, these properties should be in a Settings or UserPreference object
    
    static let nUsernameDidChange = Notification.Name("nUsernameDidChange")
    static let nProfileImageUrlDidChange = Notification.Name("nProfileImageUrlDidChange")
    
    // Note: Use string as keys or BDPersistKey for type-safe keys.
    enum Keys: BDPersistKey {
        var prefix: String { "some.prefix." }
        case username
        case profileImageUrl
    }
    
    @BDPersist(in: .userDefaults, key: Keys.username, default: "", post: nUsernameDidChange)
    static var username: String
    
    @BDPersist(in: .userDefaults, key: Keys.profileImageUrl, default: nil, post: nProfileImageUrlDidChange)
    static var profileImageUrl: String?
    
    @State private var textFieldUsername = ""
    @State private var notificationUsername = ""
    
    @State private var textFieldProfileImageUrl = ""
    @State private var notificationProfileImageUrl = ""
    
    let usernamePublisher = NotificationCenter.default.publisher(for: nUsernameDidChange)
    let profileImagePublisher = NotificationCenter.default.publisher(for: nProfileImageUrlDidChange)
    
    
    var body: some View {
        Form {
            Section(header: Text("NON-OPTIONAL VALUE")) {
                Text("Persist Username: \(Self.username)")
                
                Text("Notification Username: \(notificationUsername)")
                
                TextField("Username", text: $textFieldUsername)
                
                Button("Update Username") {
                    Self.username = self.textFieldUsername
                }
            }
            
            Section(header: Text("OPTIONAL VALUE")) {
                Text("Persist Profile Image URL: \(Self.profileImageUrl ?? "nil")")
                
                Text("Notification Profile Image URL: \(notificationProfileImageUrl)")
                
                TextField("Image URL", text: $textFieldProfileImageUrl)
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                
                Button("Update URL") {
                    let url = self.textFieldProfileImageUrl
                    Self.profileImageUrl = url.isEmpty ? nil : url
                }
            }
        }
        .onReceive(usernamePublisher.receive(on: DispatchQueue.main)) { notification in
            let username = notification.object as? String
            self.notificationUsername = username ?? "nil"
        }
        .onReceive(profileImagePublisher.receive(on: DispatchQueue.main)) { notification in
            let url = notification.object as? String
            self.notificationProfileImageUrl = url ?? "nil"
        }
    }
}


struct PersistPropertyWrapperPreview_Previews: PreviewProvider {
    static var previews: some View {
        PersistPropertyWrapperPreview()
    }
}
