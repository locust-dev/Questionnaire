//
//  KnowlegdeBaseRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowlegdeBaseRouterInput {  }

final class KnowlegdeBaseRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - KnowlegdeBaseRouterInput
extension KnowlegdeBaseRouter: KnowlegdeBaseRouterInput {  }
