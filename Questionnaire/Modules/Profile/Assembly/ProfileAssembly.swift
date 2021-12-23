//
//  ProfileAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

final class ProfileAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for ProfileModule")
        }
        
        let networkClient = NetworkClient()
        let databaseService = FBDatabaseService(networkClient: networkClient)
        let authService = FBAuthService()
        
        let dataConverter = ProfileDataConverter()
        let tableViewManager = ProfileTableViewManager()
        
        let interactor = ProfileInteractor(databaseService: databaseService, authService: authService)
        let view = ProfileViewController()
        let router = ProfileRouter(transition: view)
        let presenter = ProfilePresenter(dataConverter: dataConverter, moduleOutput: model.moduleOutput)
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        view.tabBarItem.title = model.defaulTabBarTitle
        view.tabBarItem.image = Images.tabbar_profile()
        
        return  CommonNavigationController(rootViewController: view)
    }

}


// MARK: - Model
extension ProfileAssembly {
    
    struct Model: TransitionModel {
        
        weak var moduleOutput: ProfileModuleOutput?
        let defaulTabBarTitle: String
    }
    
}
