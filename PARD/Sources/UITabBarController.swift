//
//  UITabBarController.swift
//  PARD
//
//  Created by 진세진 on 7/9/24.
//

import UIKit


extension UITabBarController {
    func setTabBarVisible(visible: Bool, animated: Bool) {
        if (tabBarIsVisible() == visible) { return }
        
        let frame = tabBar.frame
        let offset = (visible ? -frame.size.height : frame.size.height)
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        UIView.animate(withDuration: duration, animations: {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        })
    }
    
    func tabBarIsVisible() -> Bool {
        return tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}
