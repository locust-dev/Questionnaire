//
//  RegistrationAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

final class RegistrationAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for Registration module")
        }
        
        let authService = FBAuthService()
        let networkClient = NetworkClient()
        let databaseService = FBDatabaseService(networkClient: networkClient)
        
        let view = RegistrationViewController()
        let router = RegistrationRouter(transition: view)
        let presenter = RegistrationPresenter(token: model.token, moduleOutput: model.moduleOutput)
        let interactor = RegistrationInteractor(authService: authService, databaseService: databaseService)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }

}


// MARK: - Model
extension RegistrationAssembly {
    
    struct Model: TransitionModel {
        
        weak var moduleOutput: RegistrationModuleOutput?
        let token: String
    }
    
}
