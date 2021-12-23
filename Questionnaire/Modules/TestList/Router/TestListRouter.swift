//
//  TestListRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestListRouterInput {
    func openTest(with questions: [Question], testId: String)
}

final class TestListRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - TestListRouterInput
extension TestListRouter: TestListRouterInput {
    
    func openTest(with questions: [Question], testId: String) {
        let model = TestQuestionAssembly.Model(questions: questions, testId: testId)
        transition.push(with: model, openModuleType: TestQuestionAssembly.self)
    }
}
