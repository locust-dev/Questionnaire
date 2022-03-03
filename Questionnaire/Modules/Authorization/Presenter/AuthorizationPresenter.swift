//
//  AuthorizationPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol AuthorizationViewOutput: ViewOutput {
    func didTapConfirmButton(email: String?, password: String?)
    func didTapRegisterButton()
}

protocol AuthorizationInteractorOutput: AnyObject {
    func didSuccessAuthorize()
    func didFailAuthorize(email: String?, error: ErrorModel)
    func didSuccessToSaveNewUser()
    func didFailToSaveNewUser(error: ErrorModel)
}

protocol AuthorizationModuleOutput: AnyObject {
    func didSuccessAuthorized()
}

final class AuthorizationPresenter {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let tempUserName = "Default"
        static let tempUserSurname = "Username"
        static let defaultAllowedTest = "Junior1"
    }
    
    // MARK: - Properties
    
    weak var view: AuthorizationViewInput?
    
    var router: AuthorizationRouterInput?
    var interactor: AuthorizationInteractorInput?
    
    private let moduleOutput: AuthorizationModuleOutput?
    
    
    // MARK: - Init
    
    init(moduleOutput: AuthorizationModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
    
}


// MARK: - AuthorizationViewOutput
extension AuthorizationPresenter: AuthorizationViewOutput {
    
    func viewIsReady() {
        
        let viewModel = AuthorizationViewModel(mainTitle: Localized.authtorizationMainTitle(),
                                               subtitle: Localized.authtorizationSubtitle(),
                                               confirmButtonTitle: Localized.authtorizationEnter(),
                                               forgotPassButtonTitle: Localized.authtorizationForgotPassword())
        view?.update(with: viewModel)
    }
    
    func didTapConfirmButton(email: String?, password: String?) {
        view?.showHUD()
        interactor?.tryToSignIn(email: email ?? "", password: password ?? "")
    }
    
    func didTapRegisterButton() {
        router?.openRegistration(email: nil, moduleOutput: moduleOutput as? RegistrationModuleOutput)
    }
    
}


// MARK: AuthorizationInteractorOutput
extension AuthorizationPresenter: AuthorizationInteractorOutput {
    
    func didFailAuthorize(email: String?, error: ErrorModel) {
        
        view?.hideHUD()
        
        if error == .userNotFound {
            view?.showErrorAlert(message: error.description)
            
        } else if error == .userNotFoundInDatabase {
            router?.openRegistration(email: email, moduleOutput: moduleOutput as? RegistrationModuleOutput)
            
        } else {
            view?.showErrorAlert(message: error.description)
        }
    }
    
    func didSuccessAuthorize() {
        view?.hideHUD()
        moduleOutput?.didSuccessAuthorized()
    }
    
    func didSuccessToSaveNewUser() {
        view?.hideHUD()
        moduleOutput?.didSuccessAuthorized()
    }
    
    func didFailToSaveNewUser(error: ErrorModel) {
        view?.hideHUD()
        view?.showErrorAlert(message: error.description)
    }
    
}
