//
//  RegistrationRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol RegistrationRouterInput {

}

final class RegistrationRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - RegistrationRouterInput
extension RegistrationRouter: RegistrationRouterInput {

}
