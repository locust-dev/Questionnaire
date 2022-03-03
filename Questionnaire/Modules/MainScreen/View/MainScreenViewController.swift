//
//  MainScreenViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol MainScreenViewInput: AnyObject {
    func setViewControllers(isAuthorized: Bool?)
    func updateProfileTabUsername(_ username: String)
}

final class MainScreenViewController: UITabBarController {
    
    // MARK: - Properties
    
    var presenter: MainScreenViewOutput?
    
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
        
        presenter?.viewWillAppear()
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
        
        tabBar.unselectedItemTintColor = .gray
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
    
    func setViewControllers(isAuthorized: Bool?) {
        
        let userModule: UIViewController
        
        if isAuthorized == true {
            let profileModel = ProfileAssembly.Model(moduleOutput: presenter as? ProfileModuleOutput,
                                                     defaulTabBarTitle: Localized.tabBarProfile())
            
            userModule = ProfileAssembly.assembleModule(with: profileModel)
            
        } else {
            let authModel = AuthorizationAssembly.Model(moduleOutput: presenter as? AuthorizationModuleOutput,
                                                        defaultTabBarTitle: Localized.tabBarProfile())
            
            userModule = AuthorizationAssembly.assembleModule(with: authModel)
        }
        
        let testsModel = TestCategoriesAssembly.Model(tabBarTitle: Localized.tabBarTests())
        let testsModule = TestCategoriesAssembly.assembleModule(with: testsModel)
        
        let knowlegdeModel = KnowlegdeBaseAssembly.Model(tabBarTitle: Localized.tabBarKnowledgeBase())
        let knowledgeModule = KnowlegdeBaseAssembly.assembleModule(with: knowlegdeModel)
        
        self.viewControllers = [testsModule, knowledgeModule, userModule]
    }
    
    func updateProfileTabUsername(_ username: String) {
   
        let profileVC = viewControllers?.first {
            ($0 as? UINavigationController)?.topViewController is ProfileViewController
        }
        
        profileVC?.tabBarItem.title = username
    }
    
}
