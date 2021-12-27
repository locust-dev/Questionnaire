//
//  AuthorizationPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol AuthorizationViewOutput: ViewOutput {
    func didTapConfirmButton(email: String?, password: String?)
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
        static let defaultAllowedTest = "GCD1"
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
    
    
    // MARK: - Private methods
    
    private func createDefaultUser() {
        
        view?.showHUD()
        
        guard let userToken = interactor?.currentUserToken else {
            return
        }
        
        let defaultUserTemplate = NewUserDatabase(uniqueToken: userToken,
                                                  firstName: Locals.tempUserName,
                                                  lastName: Locals.tempUserSurname,
                                                  allowedTests: [Locals.defaultAllowedTest])
        
        interactor?.writeNewUserInDatabase(defaultUserTemplate)
    }
    
}


// MARK: - AuthorizationViewOutput
extension AuthorizationPresenter: AuthorizationViewOutput {
    
    func viewIsReady() {
        
        // TODO: - From config
        let viewModel = AuthorizationViewModel(mainTitle: "Добро пожаловать!", subtitle: "Пожалуйста, войдите", confirmButtonTitle: "Войти", forgotPassButtonTitle: "Забыли пароль?")
        view?.update(with: viewModel)
    }
    
    func didTapConfirmButton(email: String?, password: String?) {
        view?.showHUD()
        interactor?.tryToSignIn(email: email ?? "", password: password ?? "")
    }
    
}


// MARK: AuthorizationInteractorOutput
extension AuthorizationPresenter: AuthorizationInteractorOutput {
    
    func didFailAuthorize(email: String?, error: ErrorModel) {
        
        view?.hideHUD()
        
        if error == .userNotFound {
            router?.openRegistration(email: email, moduleOutput: moduleOutput as? RegistrationModuleOutput)
            
        } else if error == .userNotFoundInDatabase {
            createDefaultUser()
            
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
