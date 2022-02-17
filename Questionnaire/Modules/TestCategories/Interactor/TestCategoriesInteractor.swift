//
//  TestCategoriesInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import Foundation

protocol TestCategoriesInteractorInput {
    
    var isAuthorized: Bool { get }
    
    func getCategories()
}

final class TestCategoriesInteractor {
    
    // MARK: - Properties
    
    weak var presenter: TestCategoriesInteractorOutput?

    private let databaseService: DatabaseService
    private let authService: AuthorizationService
    

    // MARK: - Init
    
    init(databaseService: DatabaseService,
         authService: AuthorizationService) {
        
        self.databaseService = databaseService
        self.authService = authService
    }
    
}


// MARK: - MainScreenInteractorInput
extension TestCategoriesInteractor: TestCategoriesInteractorInput {
    
    var isAuthorized: Bool {
        authService.isAuthorized
    }
    
    func getCategories() {
        
        databaseService.getData(.categories, modelType: [TestCategoryModel].self) { [weak self] result in
            
            switch result {

            case .success(let categoriesModel):
                
                mainQueue(delay: 3) {
                    
                    self?.presenter?.didSuccessObtain(categories: categoriesModel)
                }

            case .failure(let error):
                self?.presenter?.didFailObtainCategories(error: error)
            }
        }
    }
    
}
