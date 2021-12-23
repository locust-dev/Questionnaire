//
//  TestQuestionRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestQuestionRouterInput {
    func openResults(moduleOutput: TestResultModuleOutput, userAnswers: [Int: Int], testId: String)
    func openQuestionWithMistake(_ questionMistakeModel: QuestionMistakeModel)
    func closeModule()
}

final class TestQuestionRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - TestQuestionRouterInput
extension TestQuestionRouter: TestQuestionRouterInput {
    
    func openResults(moduleOutput: TestResultModuleOutput, userAnswers: [Int: Int], testId: String) {
        
        let model = TestResultAssembly.Model(moduleOutput: moduleOutput,
                                             userAnswers: userAnswers,
                                             testId: testId)
        
        transition.push(with: model, openModuleType: TestResultAssembly.self)
    }
    
    func closeModule() {
        transition.closeCurrentModule(animated: true)
    }
    
    func openQuestionWithMistake(_ questionMistakeModel: QuestionMistakeModel) {
        let model = TestQuestionMistakeAssembly.Model(questionMistakeModel: questionMistakeModel)
        transition.present(with: model, openModuleType: TestQuestionMistakeAssembly.self)
    }
    
}
