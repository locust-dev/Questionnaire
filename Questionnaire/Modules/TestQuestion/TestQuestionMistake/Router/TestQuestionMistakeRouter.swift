//
//  TestQuestionMistakeRouter.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

protocol TestQuestionMistakeRouterInput {
    func closeModule()
}

final class TestQuestionMistakeRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - TestQuestionMistakeRouterInput
extension TestQuestionMistakeRouter: TestQuestionMistakeRouterInput {

    func closeModule() {
        transition.dismiss(animated: true)
    }
    
}
