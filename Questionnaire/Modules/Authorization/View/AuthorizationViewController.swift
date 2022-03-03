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

final class AuthorizationViewController: KeyboardShowableViewController {
    
    // MARK: - Properties
    
    var presenter: AuthorizationViewOutput?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let loginTextField = BottomLineTextField()
    private let passwordTextField = BottomLineTextField()
    private let confirmButton = CommonButton(style: .filled)
    private let registerButton = CommonButton(style: .shadow)
    private let forgotPasswordButton = UIButton()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        navigationItem.backButtonTitle = ""
        
        loginTextField.delegate = self
        loginTextField.setStyle(.email)
        
        passwordTextField.delegate = self
        passwordTextField.setStyle(.password)
        
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
                                                       confirmButton,
                                                       registerButton])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.setCustomSpacing(50, after: subtitleLabel)
        stackView.setCustomSpacing(20, after: loginTextField)
        stackView.setCustomSpacing(60, after: passwordTextField)
        stackView.setCustomSpacing(10, after: confirmButton)
        
        titleLabel.font = MainFont.bold.withSize(30)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = MainFont.regular.withSize(16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        
        forgotPasswordButton.setTitleColor(.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = MainFont.medium.withSize(14)
        forgotPasswordButton.titleLabel?.textAlignment = .right
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
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
    
    @objc private func register() {
        presenter?.didTapRegisterButton()
    }
    
    @objc private func forgotPassword() {
        // TODO: - Допилить message
        showAlert(title: Localized.authtorizationForgotPassword(),
                  message: "Пожалуйста, обратитесь к @turin_ilya")
    }
    
}


// MARK: - AuthorizationViewInput
extension AuthorizationViewController: AuthorizationViewInput {
    
    func showErrorAlert(message: String) {
        showAlert(title: Localized.alertError(), message: message, buttonTitle: Localized.buttonOkTitle())
    }
    
    func update(with viewModel: AuthorizationViewModel) {
        titleLabel.text = viewModel.mainTitle
        subtitleLabel.text = viewModel.subtitle
        confirmButton.setTitle(viewModel.confirmButtonTitle, for: .normal)
        registerButton.setTitle(Localized.authtorizationRegister(), for: .normal)
        forgotPasswordButton.setTitle(viewModel.forgotPassButtonTitle, for: .normal)
    }
}
