//
//  KnowledgeDetailPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowledgeDetailViewOutput: ViewOutput {  }

final class KnowledgeDetailPresenter {
    
    // MARK: - Properties
    
    weak var view: KnowledgeDetailViewInput?
    
    var router: KnowledgeDetailRouterInput?
    
    private let knowledgeTopic: KnowledgeTopic
    
    
    // MARK: - Init
    
    init(knowledgeTopic: KnowledgeTopic) {
        self.knowledgeTopic = knowledgeTopic
    }
    
}


// MARK: - KnowledgeDetailViewOutput
extension KnowledgeDetailPresenter: KnowledgeDetailViewOutput {
    
    func viewIsReady() {
        let viewModel = KnowledgeDetailViewModel(title: knowledgeTopic.title, text: knowledgeTopic.text)
        view?.update(with: viewModel)
    }
    
}
