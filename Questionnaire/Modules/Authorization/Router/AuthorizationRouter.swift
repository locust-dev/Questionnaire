//
//  AuthorizationRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol AuthorizationRouterInput {
    func openRegistration(userToken: String, moduleOutput: RegistrationModuleOutput?)
}

final class AuthorizationRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - AuthorizationRouterInput
extension AuthorizationRouter: AuthorizationRouterInput {
    
    func openRegistration(userToken: String, moduleOutput: RegistrationModuleOutput?) {
        let model = RegistrationAssembly.Model(moduleOutput: moduleOutput, token: userToken)
        transition.push(with: model, openModuleType: RegistrationAssembly.self)
    }
    
}
