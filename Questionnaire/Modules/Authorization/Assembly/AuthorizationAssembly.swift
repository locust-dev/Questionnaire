//
//  AuthorizationAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

final class AuthorizationAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for AuthorizationModule")
        }
        
        let networkClient = NetworkClient()
        let authService = FBAuthService()
        let databaseService = FBDatabaseService(networkClient: networkClient)
        
        let view = AuthorizationViewController()
        let router = AuthorizationRouter(transition: view)
        let presenter = AuthorizationPresenter(moduleOutput: model.moduleOutput)
        let interactor = AuthorizationInteractor(authorizationService: authService,
                                                 databaseService: databaseService)
        
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.tabBarItem.title = model.defaultTabBarTitle
        view.tabBarItem.image = Images.tabbar_profile()
        
        return CommonNavigationController(rootViewController: view)
    }

}


// MARK: - Model
extension AuthorizationAssembly {
    
    struct Model: TransitionModel {
        
        weak var moduleOutput: AuthorizationModuleOutput?
        let defaultTabBarTitle: String
    }
    
}
