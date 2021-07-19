//
//  UIViewController+Extensions.swift
//  StorytelTests
//
//  Created by Anil Goktas on 7/19/21.
//

import UIKit

extension UIViewController {
    
    func becomeActive() {
        UIView.setAnimationsEnabled(false)
        loadViewIfNeeded()
        viewWillAppear(false)
        viewDidAppear(false)
        UIView.setAnimationsEnabled(true)
    }
    
}
