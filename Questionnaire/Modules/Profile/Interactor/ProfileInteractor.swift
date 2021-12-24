//
//  ProfileInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 16.12.2021.
//

protocol ProfileInteractorInput {
    func fetchUserData()
    func logOut()
}

final class ProfileInteractor {
    
    // MARK: - Properties
    
    weak var presenter: ProfileInteractorOutput?
    
    private let databaseService: DatabaseService
    private let authService: AuthorizationService
    

    // MARK: - Init
    
    init(databaseService: DatabaseService,
         authService: AuthorizationService) {
        
        self.databaseService = databaseService
        self.authService = authService
    }
    
}


// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
    
    func logOut() {
        authService.logOut()
    }
    
    func fetchUserData() {
        
        guard let userToken = authService.currentUserToken else {
            presenter?.didFailFetchUserData(error: .errorToLoadUserInfo)
            return
        }
        
        databaseService.getData(.user(token: userToken), modelType: ProfileModel.self) { [weak self] result in
            
            switch result {
                
            case .success(let profileModel):
                self?.presenter?.didSuccessFetchUserData(profile: profileModel)
                
            case .failure(let error):
                self?.presenter?.didFailFetchUserData(error: error)
            }
        }
    }
    
}
