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
    
    
    // MARK: - Private methods

    private func createViewControllers() -> [UIViewController] {
        
        let userModule: Module
        
        if interactor?.isAuthorized == true {
            let profileModel = ProfileAssembly.Model(moduleOutput: self , defaulTabBarTitle: "Профиль")
            userModule = ProfileAssembly.assembleModule(with: profileModel)
            
        } else {
            // TODO: - From config
            let authModel = AuthorizationAssembly.Model(moduleOutput: self, defaultTabBarTitle: "Профиль")
            userModule = AuthorizationAssembly.assembleModule(with: authModel)
        }
        
        // TODO: - From config
        let testsModel = TestCategoriesAssembly.Model(tabBarTitle: "Тесты")
        let testsModule = TestCategoriesAssembly.assembleModule(with: testsModel)
        
        return [testsModule, userModule]
    }

}


// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    
    func viewWillAppear() {
        view?.set(viewControllers: createViewControllers())
        interactor?.getUserFullname()
    }
}


// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    
    func didObtainFullname(_ fullname: String?) {
        // TODO: - ...
        view?.updateProfileTabUsername(fullname ?? "Profile")
    }
}


// MARK: - AuthorizationModuleOutput
extension MainScreenPresenter: AuthorizationModuleOutput {
    
    func didSuccessAuthorized() {
        view?.set(viewControllers: createViewControllers())
    }
}


// MARK: - ProfileModuleOutput
extension MainScreenPresenter: ProfileModuleOutput {
    
    func didTapLogOutButton() {
        interactor?.logOut()
        view?.set(viewControllers: createViewControllers())
    }
}


// MARK: - RegistrationModuleOutput
extension MainScreenPresenter: RegistrationModuleOutput {
    
    func didSuccessToSaveNewUser() {
        view?.set(viewControllers: createViewControllers())
    }
}
