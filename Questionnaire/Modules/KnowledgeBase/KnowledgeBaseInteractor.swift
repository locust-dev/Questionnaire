//
//  KnowledgeBaseInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.02.2022.
//

import Foundation

protocol KnowledgeBaseInteractorInput {
    func fetchKnowledgeCategories()
}

final class KnowledgeBaseInteractor {
    
    // MARK: - Properties
    
    weak var presenter: KnowlegdeBaseInteractorOutput?
    
    private let databaseService: DatabaseServiceInput
    
    
    // MARK: - Init
    
    init(databaseService: DatabaseServiceInput) {
        self.databaseService = databaseService
    }
    
}


// MARK: - KnowledgeBaseInteractorInput
extension KnowledgeBaseInteractor: KnowledgeBaseInteractorInput {
    
    func fetchKnowledgeCategories() {
        
        databaseService.getData(DatabasePath.knowledgeBase, modelType: [KnowledgeCategoryModel].self) { result in
            
            mainQueue {
                
                switch result {
                    
                case .success(let knowledgeModel):
                    self.presenter?.didSuccessObtainKnowledgeCategories(knowledgeModel)
                    
                case .failure(let error):
                    self.presenter?.didFailObtainKnowledgeCategories(error)
                }
            }
        }
    }
    
}
