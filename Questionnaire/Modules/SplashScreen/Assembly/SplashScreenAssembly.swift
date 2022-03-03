//
//  SplashScreenAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 03.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class SplashScreenAssembly: Assembly {
    
    static func assembleModule() -> Module {
        
        let networkClient = NetworkClient()
        let databaseService = DatabaseService(networkClient: networkClient)
        let configService = ConfigService(databaseService: databaseService)
        
        let view = SplashScreenViewController()
        let presenter = SplashScreenPresenter()
        let interactor = SplashScreenInteractor(configService: configService)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }

}
