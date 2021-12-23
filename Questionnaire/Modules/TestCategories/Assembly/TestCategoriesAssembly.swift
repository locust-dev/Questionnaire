//
//  TestCategoriesAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

final class TestCategoriesAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for TestCategoriesModule")
        }
        
        let authService = FBAuthService()
        let networkClient = NetworkClient()
        let databaseService = FBDatabaseService(networkClient: networkClient)
    
        let dataConverter = TestCategoriesDataConverter()
        let tableViewManager = TestCategoriesTableViewManager()
        let view = TestCategoriesViewController()
        let router = TestCategoriesRouter(transition: view)
        let presenter = TestCategoriesPresenter(dataConverter: dataConverter)
        let interactor = TestCategoriesInteractor(databaseService: databaseService, authService: authService)
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        tableViewManager.delegate = presenter
        
        view.tabBarItem.title = model.tabBarTitle
        view.tabBarItem.image = Images.tabbar_tests()
        
        return CommonNavigationController(rootViewController: view)
    }

}


// MARK: - Model
extension TestCategoriesAssembly {
    
    struct Model: TransitionModel {
        
        let tabBarTitle: String
    }
}
