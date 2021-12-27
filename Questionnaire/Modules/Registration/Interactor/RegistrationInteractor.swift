//
//  RegistrationInteractor.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol RegistrationInteractorInput {
    func writeNewUserInDatabase(_ newUser: NewUserDatabase)
    func registerUser(with email: String, and password: String)
}

final class RegistrationInteractor {
    
    // MARK: - Properties
    
    weak var presenter: RegistrationInteractorOutput?
    
    private let authService: AuthorizationServiceInput
    private let databaseService: DatabaseServiceInput
    
    
    // MARK: - Init
    
    init(authService: AuthorizationServiceInput,
         databaseService: DatabaseServiceInput) {
        
        self.authService = authService
        self.databaseService = databaseService
    }
    
}


// MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
    
    func writeNewUserInDatabase(_ newUser: NewUserDatabase) {
        
        databaseService.saveNewUser(newUser) { [weak self] result in
            
            switch result {
                
            case .success(_):
                self?.presenter?.didSuccessToSaveNewUser()
                
            case .failure(let error):
                self?.presenter?.didFailToSaveNewUser(error: error)
            }
        }
    }
    
    func registerUser(with email: String, and password: String) {
        
        authService.registerUser(with: email, and: password) { [weak self] result in
            
            switch result {
                
            case .success(let token):
                guard let token = token else {
                    self?.presenter?.didFailToRegisterNewUser(error: .serverError)
                    return
                }

                self?.authService.setCurrentUserToken(token)
                self?.presenter?.didSuccessToRegisterNewUser(token: token)
                
            case .failure(let error):
                self?.presenter?.didFailToRegisterNewUser(error: error)
            }
        }
    }
    
}
