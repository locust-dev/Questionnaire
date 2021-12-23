//
//  TestListAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.TestList
//

final class TestListAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for TestsModule")
        }
        
        let networkClient = NetworkClient()
        let databaseService = FBDatabaseService(networkClient: networkClient)
        let authService = FBAuthService()
        
        let tableViewManager = TestListTableViewManager()
        let dataConverter = TestListDataConverter()
        
        let interactor = TestListInteractor(databaseService: databaseService, authService: authService)
        let view = TestListViewController()
        let router = TestListRouter(transition: view)
        let presenter = TestListPresenter(dataConverter: dataConverter, categoryId: model.categoryId)
        
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
extension TestListAssembly {
    
    struct Model: TransitionModel {
        
        let categoryId: String
    }
    
}
