//
//  KnowledgeDetailRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowledgeDetailRouterInput {  }

final class KnowledgeDetailRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - KnowledgeDetailRouterInput
extension KnowledgeDetailRouter: KnowledgeDetailRouterInput {  }
