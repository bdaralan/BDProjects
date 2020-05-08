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
    
    class PersistObject: ObservableObject {
        static let nUsernameDidChange = Notification.Name("nUsernameDidChange")
        
        @BDPersist(in: .userDefaults, key: "username", default: "", post: nUsernameDidChange)
        var username: String
        
        @BDPersist(in: .userDefaults, key: "profileImageUrl", default: nil)
        var profileImageUrl: String?
    }
    
    @State private var textFieldUsername = ""
    @State private var notificationUsername = ""
    
    @State private var textFieldProfileImageUrl = ""
    
    @ObservedObject var persistObject = PersistObject()
    
    let usernamePublisher = NotificationCenter.default.publisher(for: PersistObject.nUsernameDidChange)
    
    
    var body: some View {
        Form {
            Section(header: Text("NON-OPTIONAL VALUE")) {
                Text("Persist Username: \(persistObject.username)")
                
                Text("Notification Username: \(notificationUsername)")
                
                TextField("Username", text: $textFieldUsername)
                
                Button("Update Username") {
                    self.persistObject.objectWillChange.send()
                    self.persistObject.username = self.textFieldUsername
                }
            }
            
            Section(header: Text("OPTIONAL VALUE")) {
                Text("Persist Profile Image URL: \(persistObject.profileImageUrl ?? "nil")")
                
                TextField("Image URL", text: $textFieldProfileImageUrl)
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                
                Button("Update URL") {
                    self.persistObject.objectWillChange.send()
                    let url = self.textFieldProfileImageUrl
                    self.persistObject.profileImageUrl = url.isEmpty ? nil : url
                }
            }
        }
        .onReceive(usernamePublisher.receive(on: DispatchQueue.main)) { notification in
            let username = notification.object as! String
            self.notificationUsername = username
        }
    }
}


struct PersistPropertyWrapperPreview_Previews: PreviewProvider {
    static var previews: some View {
        PersistPropertyWrapperPreview()
    }
}
