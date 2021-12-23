//
//  TestListInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import Foundation

protocol TestListInteractorInput {
    func fetchTests(by categoryId: String)
}

final class TestListInteractor {
    
    // MARK: - Properties
    
    weak var presenter: TestListInteractorOutput?

    private var error: ErrorModel?
    private var allowedTests: [String]?
    private var tests: [Test]?
    
    private let databaseService: FBDatabaseServiceInput
    private let authService: FBAuthServiceInput
    private let dispatchGroup = DispatchGroup()
    

    // MARK: - Init
    
    init(databaseService: FBDatabaseServiceInput,
         authService: FBAuthServiceInput) {
        
        self.databaseService = databaseService
        self.authService = authService
    }
    
    
    // MARK: - Private methods
    
    private func getAllowedTests() {

        let userToken = authService.currentUserToken ?? ""
        let path = FBDatabasePath.allowedTests(token: userToken)
    
        databaseService.getData(path, model: [String].self) { [weak self] result in

            switch result {

            case .success(let allowedTests):
                self?.allowedTests = allowedTests

            case .failure(let error):
                self?.error = error
            }

            self?.dispatchGroup.leave()
        }
    }

    private func getTests(by categoryId: String) {
        
        databaseService.getData(.test(categoryId: categoryId), model: TestsModel.self) { [weak self] result in

            switch result {

            case .success(let testsModel):
                self?.tests = testsModel.each

            case .failure(let error):
                self?.error = error
            }
           
            self?.dispatchGroup.leave()
        }
    }

}


// MARK: - MainScreenInteractorInput
extension TestListInteractor: TestListInteractorInput {
    
    func fetchTests(by categoryId: String) {
        
        dispatchGroup.enter()
        getTests(by: categoryId)
        dispatchGroup.enter()
        getAllowedTests()
       
        dispatchGroup.notify(queue: .main) {
            
            if let error = self.error {
                self.presenter?.didFailObtainTests(error: error)
                return
            }
            
            guard let allowedTests = self.allowedTests,
                  let tests = self.tests
            else {
                self.presenter?.didFailObtainTests(error: .somethingWentWrong)
                return
            }
            
            self.presenter?.didSuccessObtainTests(tests, allowedTests: allowedTests)
        }
    }
    
}
