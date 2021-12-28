//
//  TestResultRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestResultRouterInput {
    func closeModule()
    func openMistakes(mistakes: [QuestionMistakeModel]?, questions: [Question], testId: String)
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
    
    func openMistakes(mistakes: [QuestionMistakeModel]?, questions: [Question], testId: String) {
        let model = TestQuestionAssembly.Model(mistakes: mistakes, questions: questions, testId: testId)
        transition.push(with: model, openModuleType: TestQuestionAssembly.self)
    }
}
