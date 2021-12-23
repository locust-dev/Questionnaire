//
//  MainScreenAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

final class MainScreenAssembly: Assembly {
    
    static func assembleModule() -> Module {
        
        let networkClient = NetworkClient()
        let authService = FBAuthService()
        let databaseService = FBDatabaseService(networkClient: networkClient)
        
        let view = MainScreenViewController()
        let presenter = MainScreenPresenter()
        let interactor = MainScreenInteractor(databaseService: databaseService, authService: authService)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }

}
