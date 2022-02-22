//
//  KnowledgeDetailAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class KnowledgeDetailAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for KnowledgeDetail")
        }
        
        let view = KnowledgeDetailViewController()
        let router = KnowledgeDetailRouter(transition: view)
        let presenter = KnowledgeDetailPresenter(knowledgeTopic: model.knowledgeTopic)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        
        return view
    }

}


// MARK: - Model
extension KnowledgeDetailAssembly {
    
    struct Model: TransitionModel {
        
        let knowledgeTopic: KnowledgeTopic
    }
    
}
