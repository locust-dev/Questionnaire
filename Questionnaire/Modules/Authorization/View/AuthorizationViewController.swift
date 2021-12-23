//
//  AuthorizationViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 09.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit
import PureLayout

protocol AuthorizationViewInput: Alertable, Loadable {
    func update(with viewModel: AuthorizationViewModel)
    func showErrorAlert(message: String)
}

final class AuthorizationViewController: UIViewController {
	
    // MARK: - Properties
    
	var presenter: AuthorizationViewOutput?
    
    private var activeTextField: UITextField?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let loginTextField = BottomLineTextField()
    private let passwordTextField = BottomLineTextField()
    private let confirmButton = CommonButton(style: .filled)
    private let forgotPasswordButton = UIButton()
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
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        navigationItem.backButtonTitle = ""
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let stackContainer = UIView()
        stackContainer.backgroundColor = .white
        stackContainer.layer.cornerRadius = 12
        
        let appIconImageView = UIImageView(image: Images.mainIcon())
        appIconImageView.contentMode = .scaleAspectFit
        
        let appIconContainer = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       subtitleLabel,
                                                       loginTextField,
                                                       passwordTextField,
                                                       confirmButton])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.setCustomSpacing(50, after: subtitleLabel)
        stackView.setCustomSpacing(20, after: loginTextField)
        stackView.setCustomSpacing(60, after: passwordTextField)
        
        titleLabel.font = UIFont(name: MainFont.bold, size: 30)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = UIFont(name: MainFont.regular, size: 16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        
        passwordTextField.type = .password
        
        forgotPasswordButton.setTitleColor(.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont(name: MainFont.medium, size: 14)
        forgotPasswordButton.titleLabel?.textAlignment = .right
        forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmLogin), for: .touchUpInside)
        
        view.addSubview(stackContainer)
        view.addSubview(forgotPasswordButton)
        view.addSubview(appIconContainer)
        appIconContainer.addSubview(appIconImageView)
        stackContainer.addSubview(stackView)

        stackContainer.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10), excludingEdge: .top)
        stackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20))
        
        appIconContainer.autoPinEdge(.bottom, to: .top, of: stackContainer)
        appIconContainer.autoPinEdgesToSuperviewEdges(
            with: UIEdgeInsets(top: getStatusBarHeight(), left: 0, bottom: 0, right: 0),
            excludingEdge: .bottom
        )
        
        appIconImageView.autoCenterInSuperview()
        appIconImageView.autoSetDimensions(to: CGSize(width: 70, height: 70))
        
        loginTextField.autoSetDimension(.height, toSize: 50)
        passwordTextField.autoSetDimension(.height, toSize: 50)

        forgotPasswordButton.autoSetDimension(.height, toSize: 20)
        forgotPasswordButton.autoPinEdge(.right, to: .right, of: passwordTextField)
        forgotPasswordButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 6)
    }
    
    
    // MARK: - Actions
    
    @objc private func confirmLogin() {
        presenter?.didTapConfirmButton(email: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc private func forgotPassword() {
        // TODO: - From localized
        showAlert(title: "Забыли пароль?", message: "Пожалуйста, обратитесь к @turin_ilya")
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

}


// MARK: - AuthorizationViewInput
extension AuthorizationViewController: AuthorizationViewInput {
    
    func showErrorAlert(message: String) {
        // TODO: - From localized
        showAlert(title: "Ошибка", message: message, buttonTitle: "Ok")
    }
    
    func update(with viewModel: AuthorizationViewModel) {
        titleLabel.text = viewModel.mainTitle
        subtitleLabel.text = viewModel.subtitle
        confirmButton.setTitle(viewModel.confirmButtonTitle, for: .normal)
        forgotPasswordButton.setTitle(viewModel.forgotPassButtonTitle, for: .normal)
    }
}


// MARK: - UITextFieldDelegate
extension AuthorizationViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
}
