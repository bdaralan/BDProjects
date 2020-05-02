//
//  PreviewPresenter.swift
//  BDUIKnitProject
//
//  Created by Dara Beng on 4/12/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI


struct PreviewPresenter: UIViewControllerRepresentable {
    
    @State private var controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func present<Content: View>(content: Content, fullscreen: Bool) {
        let hostingVC = UIHostingController(rootView: content)
        if fullscreen {
            hostingVC.modalPresentationStyle = .fullScreen
            hostingVC.isModalInPresentation = true
        }
        controller.present(hostingVC, animated: true, completion: nil)
    }
    
    func dismissCurrentContent() {
        controller.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func present(_ preview: Preview, fullscreen: Bool) {
        present(content: preview.content, fullscreen: fullscreen)
    }
    
    func dismissPreview() {
        dismissCurrentContent()
    }
}
