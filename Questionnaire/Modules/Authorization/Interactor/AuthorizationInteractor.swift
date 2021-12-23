//
//  AuthorizationInteractor.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

protocol AuthorizationInteractorInput {
    func tryToSignIn(email: String, password: String)
}

final class AuthorizationInteractor {
    
    // MARK: - Properties
    
    weak var presenter: AuthorizationInteractorOutput?
    
    private let authorizationService: FBAuthServiceInput
    private let databaseService: FBDatabaseServiceInput
    
    
    // MARK: - Init
    
    init(authorizationService: FBAuthServiceInput,
         databaseService: FBDatabaseServiceInput) {
        
        self.authorizationService = authorizationService
        self.databaseService = databaseService
    }
    
    
    // MARK: - Private methods
    
    private func checkIfUserAlreadyInDatabase(token: String) {
        
        databaseService.getData(.user(token: token), model: ProfileModel.self) { [weak self] result in
            
            switch result {
                
            case .success(_):
                self?.authorizationService.setCurrentUserToken(token)
                self?.presenter?.didSuccessAuthorize(userToken: nil)
                
            case .failure(_):
                self?.presenter?.didSuccessAuthorize(userToken: token)
            }
        }
    }

    
}


// MARK: - MainScreenInteractorInput
extension AuthorizationInteractor: AuthorizationInteractorInput {
    
    func tryToSignIn(email: String, password: String) {
        
        authorizationService.signIn(email: email, password: password) { [weak self] result in
        
            switch result {
            case .success(let token):
                guard let token = token else {
                    self?.presenter?.didFailAuthorize(error: .serverError)
                    return
                }
                
                self?.checkIfUserAlreadyInDatabase(token: token)
                
            case .failure(let error):
                self?.presenter?.didFailAuthorize(error: error)
            }
        }
    }
    
}
