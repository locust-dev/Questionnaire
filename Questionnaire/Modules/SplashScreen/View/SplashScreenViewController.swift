//
//  SplashScreenViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 03.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol SplashScreenViewInput: ErrorPresentable {
    func openMainScreen()
}

final class SplashScreenViewController: UIViewController {
	
    // MARK: - Public properties
    
	var presenter: SplashScreenViewOutput?
    
    private let logoImage = UIImageView()
    private let loader = ProgressHUD(size: .big)
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawning
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        logoImage.image = Images.mainTextName()
        logoImage.contentMode = .scaleAspectFit
        
        loader.color = Colors.mainBlueColor()
        
        view.addSubview(logoImage)
        view.addSubview(containerView)
        containerView.addSubview(loader)
        
        logoImage.autoCenterInSuperview()
        logoImage.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        logoImage.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
        
        containerView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        containerView.autoPinEdge(.top, to: .bottom, of: logoImage)
        
        loader.autoAlignAxis(.vertical, toSameAxisOf: logoImage)
        loader.autoCenterInSuperview()
    }
    
}


// MARK: - SplashScreenViewInput
extension SplashScreenViewController: SplashScreenViewInput {
    
    func openMainScreen() {
        
        guard let window = view.window else {
            return
        }
        
        window.rootViewController = MainScreenAssembly.assembleModule()
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
    }
    
}
