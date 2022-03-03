//
//  RegistrationViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol RegistrationViewInput: Alertable, Loadable {
    func showSavingAlertError(message: String)
    func showSuccessRegistrationAlert()
    func updateViewLabels(_ email: String?)
}

final class RegistrationViewController: KeyboardShowableViewController {
    
    // MARK: - Public properties
    
    var presenter: RegistrationViewOutput?
    
    private let mainLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let firstNameTextField = BottomLineTextField()
    private let lastNameTextField = BottomLineTextField()
    private let emailTextField = BottomLineTextField()
    private let passwordTextField = BottomLineTextField()
    private let registerButton = CommonButton()
    private let stack = UIStackView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    

    // MARK: - Drawning
    
    private func drawSelf() {
         
        view.backgroundColor = Colors.mainBlueColor()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        emailTextField.setStyle(.email)
        passwordTextField.setStyle(.password)
        firstNameTextField.setStyle(.firstName)
        lastNameTextField.setStyle(.lastName)
        
        mainLabel.font = MainFont.bold.withSize(30)
        mainLabel.textColor = .black
        mainLabel.numberOfLines = 0
        mainLabel.text = Localized.registrationMainTitle()
        
        subtitleLabel.font = MainFont.regular.withSize(16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        
        registerButton.setTitle(Localized.registrationButton(), for: .normal)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        let stackContainer = UIView()
        stackContainer.backgroundColor = .white
        stackContainer.layer.cornerRadius = 12
        
        let appIconContainer = UIView()
        let appIconImageView = UIImageView(image: Images.mainIcon())
        appIconImageView.contentMode = .scaleAspectFit
        
        stack.addArrangedSubviews([mainLabel,
                                   subtitleLabel,
                                   emailTextField,
                                   passwordTextField,
                                   firstNameTextField,
                                   lastNameTextField,
                                   registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.setCustomSpacing(4, after: mainLabel)
        stack.setCustomSpacing(40, after: lastNameTextField)

        view.addSubview(stackContainer)
        stackContainer.addSubview(stack)
        view.addSubview(appIconContainer)
        appIconContainer.addSubview(appIconImageView)
        
        stackContainer.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10), excludingEdge: .top)
        stack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20))
        
        appIconContainer.autoPinEdge(.bottom, to: .top, of: stackContainer)
        appIconContainer.autoPinEdgesToSuperviewEdges(
            with: UIEdgeInsets(top: getStatusBarHeight(), left: 0, bottom: 0, right: 0),
            excludingEdge: .bottom
        )
        
        appIconImageView.autoCenterInSuperview()
        appIconImageView.autoSetDimensions(to: CGSize(width: 70, height: 70))
        
        firstNameTextField.autoSetDimension(.height, toSize: 50)
        lastNameTextField.autoSetDimension(.height, toSize: 50)
        emailTextField.autoSetDimension(.height, toSize: 50)
        passwordTextField.autoSetDimension(.height, toSize: 50)
    }
    
    
    // MARK: - Actions
    
    @objc private func register() {
        
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty
        else {
            showAlertNonOptionalFields()
            return
        }
        
        let registrationData = RegistrationData(firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                password: password)
        
        presenter?.didTapRegisterButton(registrationData: registrationData)
    }
    
    
    // MARK: - Private methods
    
    private func showAlertNonOptionalFields() {
        showAlert(title: Localized.alertError(), message: Localized.alertFillAllGaps())
    }
    
}


// MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
    func updateViewLabels(_ email: String?) {
        
        // TODO: - ...
        subtitleLabel.text = email == nil ? email : "Вы успешно авторизовались, но, для продолжения, вам необходимо зарегистрироваться"
        emailTextField.text = email
    }
    
    func showSavingAlertError(message: String) {
        showAlert(title: Localized.alertError(), message: message)
    }
    
    func showSuccessRegistrationAlert() {
        showAlert(title: Localized.alertSuccessRegistration())
    }

}
