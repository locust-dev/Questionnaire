//
//  MainScreenInteractor.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

protocol MainScreenInteractorInput {
    
    var isAuthorized: Bool { get }
    
    func logOut()
    func requestUserFullname()
}

final class MainScreenInteractor {
    
    // MARK: - Properties
    
    weak var presenter: MainScreenInteractorOutput?
    
    private let databaseService: DatabaseServiceInput
    private let authService: AuthorizationServiceInput
    
    
    // MARK: - Init
    
    init(databaseService: DatabaseServiceInput,
         authService: AuthorizationServiceInput) {
        
        self.databaseService = databaseService
        self.authService = authService
    }
    
}


// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    
    var isAuthorized: Bool {
        authService.isAuthorized
    }
    
    func logOut() {
        authService.logOut()
    }
    
    func requestUserFullname() {
        
        guard let userToken = authService.currentUserToken else {
            return
        }
        
        databaseService.getData(.user(token: userToken), modelType: ProfileModel.self) { [weak self] result in
            
            mainQueue {
                
                switch result {
                    
                case .success(let profileModel):
                    self?.presenter?.didObtainFullname(profileModel.fullName)
                    
                case .failure(_):
                    break
                }
            }
        }
    }
    
}
