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
    func didSuccessAuthorize(userToken: String?)
    func didFailAuthorize(error: ErrorModel)
}

protocol AuthorizationModuleOutput: AnyObject {
    func didSuccessAuthorized()
}

final class AuthorizationPresenter {
    
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
    
    func didFailAuthorize(error: ErrorModel) {
        view?.hideHUD()
        view?.showErrorAlert(message: error.description)
    }
    
    func didSuccessAuthorize(userToken: String?) {
        view?.hideHUD()
        
        guard let userToken = userToken else {
            moduleOutput?.didSuccessAuthorized()
            return
        }

        router?.openRegistration(userToken: userToken, moduleOutput: moduleOutput as? RegistrationModuleOutput)
    }
    
}
