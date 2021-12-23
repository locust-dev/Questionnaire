//
//  TestResultRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestResultRouterInput {
    func closeModule()
}

final class TestResultRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - TestResultRouterInput
extension TestResultRouter: TestResultRouterInput {
    
    func closeModule() {
        transition.popToRootViewController(animated: true)
    }
}
