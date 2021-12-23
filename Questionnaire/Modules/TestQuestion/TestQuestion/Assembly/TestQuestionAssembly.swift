//
//  TestQuestionAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

final class TestQuestionAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for TestQuestionModule")
        }
        
        let tableViewManager = TestQuestionTableViewManager()
        let dataConverter = TestQuestionDataConverter()
        
        let view = TestQuestionViewController()
        let router = TestQuestionRouter(transition: view)
        let presenter = TestQuestionPresenter(dataConverter: dataConverter,
                                              questions: model.questions,
                                              testId: model.testId)
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        
        return view
    }

}


// MARK: - Model
extension TestQuestionAssembly {
    
    struct Model: TransitionModel {
        
        let questions: [Question]
        let testId: String
    }
    
}
