//
//  TestResultInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import Foundation

protocol TestResultInteractorInput: AnyObject {
    func getRightAnswers(by testId: String)
}

final class TestResultInteractor {
    
    // MARK: - Properties
    
    weak var presenter: TestResultInteractorOutput?
    
    private let databaseService: FBDatabaseServiceInput
    
    
    // MARK: - Init
 
    init(databaseService: FBDatabaseServiceInput) {
        self.databaseService = databaseService
    }
    
}


// MARK: - TestResultInteractorInput
extension TestResultInteractor: TestResultInteractorInput {
    
    func getRightAnswers(by testId: String) {
        
        databaseService.getData(.rightAnswers(testId: testId), model: [Int].self) { [weak self] result in
            
            switch result {
                
            case .success(let answers):
                self?.presenter?.didSuccessObtainAnswers(answers)
                
            case .failure(let error):
                self?.presenter?.didFailObtainAnswers(error: error)
            }
        }
    }
}
