//
//  TabBarPresentable.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.12.2021.
//

import UIKit

protocol TabBarPresentable {
    
    func showTabBar()
    func hideTabBar()
}


// MARK: - Default Implementation
extension TabBarPresentable where Self: UIViewController {
    
    func showTabBar() {
        setTabBarHidden(false)
    }
    
    func hideTabBar() {
        setTabBarHidden(true)
    }
    
    
    // MARK: - Private methods
    
    private func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.2) {
        
        if animated, let frame = tabBarController?.tabBar.frame {
            
            let factor: CGFloat = hidden ? 1 : -1
            let yOffset = frame.origin.y + (frame.size.height * factor)
            let endFrame = CGRect(x: frame.origin.x, y: yOffset, width: frame.width, height: frame.height)
            
            UIView.animate(withDuration: duration, animations: {
                self.tabBarController?.tabBar.frame = endFrame
                (self.tabBarController as? MainScreenViewController)?.setCustomViewFrame(endFrame)
            })
            
            return
        }
        
        tabBarController?.tabBar.isHidden = hidden
        (tabBarController as? MainScreenViewController)?.setCustomViewFrame(.zero)
    }
}


extension UIViewController: TabBarPresentable { }
