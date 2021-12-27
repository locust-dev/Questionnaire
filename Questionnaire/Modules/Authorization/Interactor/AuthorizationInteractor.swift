//
//  AuthorizationInteractor.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

protocol AuthorizationInteractorInput {
    
    var currentUserToken: String? { get }
    
    func tryToSignIn(email: String, password: String)
    func writeNewUserInDatabase(_ newUser: NewUserDatabase)
}

final class AuthorizationInteractor {
    
    // MARK: - Properties
    
    weak var presenter: AuthorizationInteractorOutput?
    
    private let authorizationService: AuthorizationServiceInput
    private let databaseService: DatabaseServiceInput
    
    
    // MARK: - Init
    
    init(authorizationService: AuthorizationServiceInput,
         databaseService: DatabaseServiceInput) {
        
        self.authorizationService = authorizationService
        self.databaseService = databaseService
    }
    
    
    // MARK: - Private methods
    
    private func checkIfUserAlreadyInDatabase(token: String) {
        
        databaseService.getData(.user(token: token), modelType: ProfileModel.self) { [weak self] result in
            
            switch result {
                
            case .success(_):
                self?.authorizationService.setCurrentUserToken(token)
                self?.presenter?.didSuccessAuthorize()
                
            case .failure(_):
                self?.presenter?.didFailAuthorize(email: nil, error: .userNotFoundInDatabase)
            }
        }
    }

    
}


// MARK: - MainScreenInteractorInput
extension AuthorizationInteractor: AuthorizationInteractorInput {
    
    var currentUserToken: String? {
        authorizationService.currentUserToken
    }
    
    func tryToSignIn(email: String, password: String) {
        
        authorizationService.signIn(email: email, password: password) { [weak self] result in
        
            switch result {
            case .success(let token):
                guard let token = token else {
                    self?.presenter?.didFailAuthorize(email: nil, error: .serverError)
                    return
                }
                
                self?.checkIfUserAlreadyInDatabase(token: token)
                
            case .failure(let error):
                self?.presenter?.didFailAuthorize(email: email, error: error)
            }
        }
    }
    
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
    
}
