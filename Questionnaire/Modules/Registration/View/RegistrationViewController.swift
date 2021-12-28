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

final class RegistrationViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: RegistrationViewOutput?
    
    private var activeTextField: UITextField?
    
    private let mainLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let firstNameTextField = BottomLineTextField()
    private let lastNameTextField = BottomLineTextField()
    private let emailTextField = BottomLineTextField()
    private let passwordTextField = BottomLineTextField()
    private let registerButton = CommonButton()
    private let stack = UIStackView()
    private let notifitacionCenter = NotificationCenter.default
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifitacionCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notifitacionCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
        
        mainLabel.font = UIFont(name: MainFont.bold, size: 30)
        mainLabel.textColor = .black
        mainLabel.numberOfLines = 0
        mainLabel.text = "Регистрация"
        
        subtitleLabel.font = UIFont(name: MainFont.regular, size: 16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        
        // TODO: - Localized
        registerButton.setTitle("Зарегистрироваться", for: .normal)
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey],
              let keyboardSize = (keyboardFrame as? NSValue)?.cgRectValue,
              let activeTextField = activeTextField
        else {
            return
        }
        
        let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
        let topOfKeyboard = view.frame.height - keyboardSize.height
        
        if bottomOfTextField > topOfKeyboard {
            view.frame.origin.y = -(bottomOfTextField - topOfKeyboard + 20)
        }
    }

    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    
    // MARK: - Private methods
    
    private func showAlertNonOptionalFields() {
        // TODO: - Localized
        showAlert(title: "Ошибка!", message: "Пожалуйста, заполните все обязятельные поля.")
    }
    
}


// MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
    func updateViewLabels(_ email: String?) {
        subtitleLabel.text = email == nil ? email : "Вы успешно авторизовались, но, для продолжения, вам необходимо зарегистрироваться"
        emailTextField.text = email
    }
    
    func showSavingAlertError(message: String) {
        // TODO: - Localized
        showAlert(title: "Ошибка!", message: message)
    }
    
    func showSuccessRegistrationAlert() {
        // TODO: - Localized
        showAlert(title: "Ура!", message: "Вы зарегистрированы. Теперь вы можете проходить тесты.")
    }

}


// MARK: - UITextFieldDelegate
extension RegistrationViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
}
