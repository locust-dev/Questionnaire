//
//  RegistrationPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import SwiftProtobuf

protocol RegistrationViewOutput: ViewOutput {
    func didTapRegisterButton(registrationData: RegistrationData)
}

protocol RegistrationInteractorOutput: AnyObject {
    func didSuccessToRegisterNewUser(token: String)
    func didFailToRegisterNewUser(error: ErrorModel)
    func didSuccessToSaveNewUser()
    func didFailToSaveNewUser(error: ErrorModel)
}

protocol RegistrationModuleOutput: AnyObject {
    func didSuccessToSaveNewUser()
}

final class RegistrationPresenter {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let defaultTestName = "GCD1"
    }
    
    
    // MARK: - Properties
    
    weak var view: RegistrationViewInput?
    
    var interactor: RegistrationInteractorInput?
    var router: RegistrationRouterInput?
    
    private var registrationData: RegistrationData?
    
    private let email: String?
    private let moduleOutput: RegistrationModuleOutput?
    
    
    // MARK: - Init
    
    init(email: String?,
         moduleOutput: RegistrationModuleOutput?) {
        
        self.email = email
        self.moduleOutput = moduleOutput
    }
    
}


// MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {
    
    func viewIsReady() {
        view?.updateViewLabels(email)
    }
    
    func didTapRegisterButton(registrationData: RegistrationData) {
        
        self.registrationData = registrationData
    
        view?.showHUD()
        interactor?.registerUser(with: registrationData.email, and: registrationData.password)
    }
    
}


// MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func didSuccessToRegisterNewUser(token: String) {
        
        guard let registrationData = registrationData else {
            return
        }
        
        let newUserDatabase = NewUserDatabase(uniqueToken: token,
                                              firstName: registrationData.firstName,
                                              lastName: registrationData.lastName,
                                              allowedTests: [Locals.defaultTestName])
        
        interactor?.writeNewUserInDatabase(newUserDatabase)
    }
    
    func didFailToRegisterNewUser(error: ErrorModel) {
        view?.hideHUD()
        view?.showSavingAlertError(message: error.description)
    }
    
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
