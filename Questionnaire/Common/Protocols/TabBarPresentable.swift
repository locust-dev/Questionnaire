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
    
    private func setTabBarHidden(_ hidden: Bool) {
        
        guard let tabBarController = tabBarController else {
            return
        }
        
        let tabBar = tabBarController.tabBar
        let offsetY = hidden ? tabBar.frame.height : -tabBar.frame.height
        let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
        let selectedIndex = tabBarController.selectedIndex
        let targetViewController = tabBarController.viewControllers?[selectedIndex]
        var newInsets = targetViewController?.additionalSafeAreaInsets
        newInsets?.bottom -= offsetY
        
        if hidden, let insets = newInsets {
            targetViewController?.additionalSafeAreaInsets = insets
            targetViewController?.view.setNeedsLayout()
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            tabBar.frame = endFrame
            (tabBarController as? MainScreenViewController)?.setCustomViewFrame(endFrame)
            
        }) { _ in
            if !hidden, let insets = newInsets {
                targetViewController?.additionalSafeAreaInsets = insets
                targetViewController?.view.setNeedsLayout()
            }
        }
    }
    
}

extension UIViewController: TabBarPresentable { }
