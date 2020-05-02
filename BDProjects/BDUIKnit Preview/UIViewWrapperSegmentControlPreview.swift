//
//  UIViewWrapperSegmentControlPreview.swift
//  BDProjects
//
//  Created by Dara Beng on 5/1/20.
//  Copyright © 2020 Dara Beng. All rights reserved.
//

import SwiftUI
import BDUIKnit


struct UIViewWrapperSegmentControlPreview: View {
    
    // The references from makeSegmentControl() if needed
    @State private var segmentControl: UISegmentedControl!
    @State private var coordinator: SegmentControlCoordinator!
    
    @State private var todo = Todo()
    
    let segments = ["Low", "Medium", "High"]
        
    
    var body: some View {
        Form {
            // explicit BDUIViewWrapper<UISegmentedControl>(onMake:onUpdate:)
            // implicit BDUIViewWrapper(onMake:onUpdate:)
            BDUIViewWrapper(onMake: makeSegmentControl, onUpdate: updateSegmentControl)
                        
            Stepper("Todo Priority: \(todo.priority)", value: $todo.priority, in: 0...segments.count - 1)
        }
    }
    
    /// Create a segment control
    func makeSegmentControl() -> UISegmentedControl {
        // create segment and coordinator
        let segmentControl = UISegmentedControl(items: segments)
        let coordinator = SegmentControlCoordinator(control: segmentControl)
        
        // keep the references if needed
        self.segmentControl = segmentControl
        self.coordinator = coordinator
        
        // setup segment
        segmentControl.selectedSegmentIndex = todo.priority
        
        // setup coordinator
        coordinator.onSegmentChanged = {
            // update current states to match segment control
            self.todo.priority = segmentControl.selectedSegmentIndex
        }
        
        return segmentControl
    }
    
    /// Update the segment to match current state changes
    func updateSegmentControl(_ segmentControl: UISegmentedControl) {
        segmentControl.selectedSegmentIndex = todo.priority
        
        let selectedColor: UIColor?
        switch todo.priority {
        case 0: selectedColor = .systemRed
        case 1: selectedColor = .systemOrange
        case 2: selectedColor = .systemGreen
        default: selectedColor = nil
        }
        
        segmentControl.selectedSegmentTintColor = selectedColor
    }
}


private class SegmentControlCoordinator: NSObject {
    
    var onSegmentChanged: (() -> Void)?
    
    init(control: UISegmentedControl) {
        super.init()
        control.addTarget(self, action: #selector(handleSegmentChanged), for: .valueChanged)
    }
    
    @objc private func handleSegmentChanged(sender: UISegmentedControl) {
        onSegmentChanged?()
    }
}


struct UIViewWrapperSegmentControlPreview_Previews: PreviewProvider {
    static var previews: some View {
        UIViewWrapperSegmentControlPreview()
    }
}
