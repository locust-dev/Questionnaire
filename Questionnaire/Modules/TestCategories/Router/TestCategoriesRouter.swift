//
//  TestCategoriesRouter.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestCategoriesRouterInput {
    func openTests(by categoryId: String)
}

final class TestCategoriesRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - TestCategoriesRouterInput
extension TestCategoriesRouter: TestCategoriesRouterInput {
    
    func openTests(by categoryId: String) {
        let testsModel = TestListAssembly.Model(categoryId: categoryId)
        transition.push(with: testsModel, openModuleType: TestListAssembly.self)
    }
    
}
