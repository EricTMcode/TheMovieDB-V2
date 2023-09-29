//
//  NavigationController.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/09/2023.
//

import SwiftUI

// ENABLE Swipe Gesture when NavigationBar is disabled.
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
