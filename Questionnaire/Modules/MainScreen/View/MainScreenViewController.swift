//
//  MainScreenViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol MainScreenViewInput: AnyObject {
    func set(viewControllers: [UIViewController]?)
    func updateProfileTabUsername(_ username: String)
}

final class MainScreenViewController: UITabBarController {
    
    // MARK: - Properties
    
    var presenter: MainScreenViewOutput?
    
    private var isFirstLoaded = true
    
    private let customTabBarView = UIView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        customTabBarView.frame = tabBar.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstLoaded {
            presenter?.viewWillAppear()
            isFirstLoaded = false
        }
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 20
        customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabBarView.clipsToBounds = true
        
        customTabBarView.layer.masksToBounds = false
        customTabBarView.layer.shadowColor = UIColor.black.cgColor
        customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        customTabBarView.layer.shadowOpacity = 0.12
        customTabBarView.layer.shadowRadius = 10.0
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    
    // MARK: - Public methods
    
    func setCustomViewFrame(_ frame: CGRect) {
        customTabBarView.frame = frame
    }
    
}


// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
    
    func set(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func updateProfileTabUsername(_ username: String) {
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            let navigationVC = viewController as? UINavigationController
            let profileVC = navigationVC?.topViewController as? ProfileViewController
            profileVC?.tabBarItem.title = username
        }
    }
    
}
