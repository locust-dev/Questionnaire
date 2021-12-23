//
//  RegistrationPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol RegistrationViewOutput: ViewOutput {
    func didTapRegisterButton(firstName: String?, lastName: String?)
}

protocol RegistrationInteractorOutput: AnyObject {
    func didSuccessToSaveNewUser()
    func didFailToSaveNewUser(error: ErrorModel)
}

protocol RegistrationModuleOutput: AnyObject {
    func didSuccessToSaveNewUser()
}

final class RegistrationPresenter {
    
    // MARK: - Properties
    
    weak var view: RegistrationViewInput?
    
    var interactor: RegistrationInteractorInput?
    var router: RegistrationRouterInput?
    
    private let token: String
    private let moduleOutput: RegistrationModuleOutput?
    
    
    // MARK: - Init
    
    init(token: String,
         moduleOutput: RegistrationModuleOutput?) {
        
        self.token = token
        self.moduleOutput = moduleOutput
    }
    
}


// MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {
    
    func didTapRegisterButton(firstName: String?, lastName: String?) {
        
        guard let firstName = firstName,
              let lastName = lastName,
              !firstName.isEmpty,
              !lastName.isEmpty
        else {
            view?.showAlertNonOptionalFields()
            return
        }
        
        let newUser = NewUserModel(uniqueToken: token, firstName: firstName, lastName: lastName)
        
        view?.showHUD()
        interactor?.writeNewUserInDatabase(newUser)
    }
}


// MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func didSuccessToSaveNewUser() {
        view?.hideHUD()
        view?.showSuccessRegistrationAlert()
        moduleOutput?.didSuccessToSaveNewUser()
    }
    
    func didFailToSaveNewUser(error: ErrorModel) {
        view?.hideHUD()
        view?.showSavingAlertError(message: error.description)
    }
    
}
