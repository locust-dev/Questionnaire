//
//  TestResultAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

final class TestResultAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for TestResultModule")
        }
        
        let networkClient = NetworkClient()
        let databaseService = DatabaseService(networkClient: networkClient)
        
        let tableViewManager = TestResultTableViewManager()
        let dataConverter = TestResultDataConverter()
        
        let interactor = TestResultInteractor(databaseService: databaseService)
        let view = TestResultViewController()
        let router = TestResultRouter(transition: view)
        let presenter = TestResultPresenter(questions: model.questions,
                                            dataConverter: dataConverter,
                                            userAnswers: model.userAnswers,
                                            testId: model.testId)
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }

}


// MARK: - Model
extension TestResultAssembly {
    
    struct Model: TransitionModel {
        
        let userAnswers: [UserAnswerModel]
        let testId: String
        let questions: [Question]
    }
    
}
