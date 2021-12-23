//
//  ProfilePresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol ProfileViewOutput: ViewOutput {
    func didTapLogOutButton()
}

protocol ProfileModuleOutput: AnyObject {
    func didTapLogOutButton()
}

protocol ProfileInteractorOutput: AnyObject {
    func didSuccessFetchUserData(profile: ProfileModel)
    func didFailFetchUserData(error: ErrorModel)
}

final class ProfilePresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileViewInput?
    
    var router: ProfileRouterInput?
    var interactor: ProfileInteractorInput?
    
    private let moduleOutput: ProfileModuleOutput?
    private let dataConverter: ProfileDataConverterInput
    
    
    // MARK: - Init
    
    init(dataConverter: ProfileDataConverterInput,
         moduleOutput: ProfileModuleOutput?) {
        
        self.dataConverter = dataConverter
        self.moduleOutput = moduleOutput
    }
    
}


// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    
    func viewIsReady() {
        view?.showHUD()
        interactor?.fetchUserData()
    }
    
    func didTapLogOutButton() {
        moduleOutput?.didTapLogOutButton()
    }
    
}


// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    
    func didSuccessFetchUserData(profile: ProfileModel) {
        view?.hideHUD()
        let viewModel = dataConverter.convert(profileModel: profile)
        view?.update(with: viewModel)
    }
    
    func didFailFetchUserData(error: ErrorModel) {
    
        view?.hideHUD()
        
        if error == .errorToLoadUserInfo {
            interactor?.logOut()
            moduleOutput?.didTapLogOutButton()
        }
    }
    
}
