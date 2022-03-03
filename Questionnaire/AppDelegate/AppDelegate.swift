//
//  AppDelegate.swift
//  Questionnaire
//
//  Created by Ilya Turin on 08.12.2021.
//

import UIKit
import Firebase

#if DEBUG
    import CocoaDebug
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backIndicatorImage = Images.arrowReversed()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Images.arrowReversed()
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: MainFont.medium.withSize(10)], for: .normal)
        
        FirebaseApp.configure()
        makeRootViewController()
        return true
    }

}


// MARK: - Private methods
extension AppDelegate {
    
    private func makeRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = SplashScreenAssembly.assembleModule()
    }
    
}
