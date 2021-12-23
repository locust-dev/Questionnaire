//
//  TestQuestionMistakeAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

final class TestQuestionMistakeAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for TestQuestionMistakeModule")
        }
        
        let tableViewManager = TestQuestionMistakeTableViewManager()
        let dataConverter = TestQuestionMistakeDataConverter()
        
        let view = TestQuestionMistakeViewController()
        let router = TestQuestionMistakeRouter(transition: view)
        let presenter = TestQuestionMistakePresenter(dataConverter: dataConverter,
                                                     questionMistakeModel: model.questionMistakeModel)
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        
        return view
    }

}


// MARK: - Model
extension TestQuestionMistakeAssembly {
    
    struct Model: TransitionModel {
        
        let questionMistakeModel: QuestionMistakeModel
    }
    
}
