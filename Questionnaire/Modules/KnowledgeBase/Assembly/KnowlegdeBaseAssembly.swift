//
//  KnowlegdeBaseAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

final class KnowlegdeBaseAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for KnowledgeBase module")
        }
        
        let childModule = createChildModule(with: model)
        let containerModule = KnowledgeBaseContainerViewController(childModule: childModule)
        
        containerModule.tabBarItem.title = model.tabBarTitle
        containerModule.tabBarItem.image = Images.tabbar_knowledge()
        
        return UINavigationController(rootViewController: containerModule)
    }
    
    private static func createChildModule(with model: Model) -> Module {
        
        let networkClient = NetworkClient()
        let databaseService = DatabaseService(networkClient: networkClient)
        
        let tableViewManager = KnowlegdeBaseTableViewManager()
        let dataConverter = KnowlegdeBaseDataConverter()
        
        let interactor = KnowledgeBaseInteractor(databaseService: databaseService)
        let view = KnowlegdeBaseViewController()
        let router = KnowlegdeBaseRouter(transition: view)
        let presenter = KnowlegdeBasePresenter(dataConverter: dataConverter)
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }

}


// MARK: - Model
extension KnowlegdeBaseAssembly {
    
    struct Model: TransitionModel {
        
        let tabBarTitle: String
    }
    
}
