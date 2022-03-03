//
//  MainScreenPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol MainScreenViewOutput: ViewOutput {  }

protocol MainScreenInteractorOutput: AnyObject {
    func didObtainFullname(_ fullname: String?)
}

final class MainScreenPresenter {
    
    // MARK: - Properties
    
    weak var view: MainScreenViewInput?
    
    var interactor: MainScreenInteractorInput?
    
    private var isFirstLoaded = true

}


// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    
    func viewWillAppear() {
        if isFirstLoaded {
            view?.setViewControllers(isAuthorized: interactor?.isAuthorized)
            interactor?.requestUserFullname()
            isFirstLoaded = false
        }
    }
}


// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    
    func didObtainFullname(_ fullname: String?) {
        view?.updateProfileTabUsername(fullname ?? Localized.tabBarProfile())
    }
}


// MARK: - AuthorizationModuleOutput
extension MainScreenPresenter: AuthorizationModuleOutput {
    
    func didSuccessAuthorized() {
        view?.setViewControllers(isAuthorized: interactor?.isAuthorized)
    }
}


// MARK: - ProfileModuleOutput
extension MainScreenPresenter: ProfileModuleOutput {
    
    func didTapLogOutButton() {
        interactor?.logOut()
        view?.setViewControllers(isAuthorized: interactor?.isAuthorized)
    }
}


// MARK: - RegistrationModuleOutput
extension MainScreenPresenter: RegistrationModuleOutput {
    
    func didSuccessToSaveNewUser() {
        view?.setViewControllers(isAuthorized: interactor?.isAuthorized)
    }
}
