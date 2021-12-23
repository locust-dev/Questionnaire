//
//  BottomLineTextField.swift
//  Questionnaire
//
//  Created by Ilya Turin on 18.12.2021.
//

import UIKit

final class BottomLineTextField: NLTextField {
    
    // MARK: - Locals
    
    private enum Locals {
            
        static let leftImageFrame = CGRect(x: 0, y: 0, width: 20, height: 20)
        static let textInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    }
    
    
    // MARK: - Types
    
    enum TextFieldType {
        
        case email
        case password
        case firstName
        case lastName
    }
    
    
    // MARK: - Properties
    
    var type: TextFieldType = .email {
        didSet {
            configureByType()
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureByType()
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        setupBottomLine()
        setupPlaceholder()
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    
    // MARK: - Public methods
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Locals.textInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Locals.textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Locals.textInsets)
    }
    
    
    // MARK: - Actions
    
    @objc private func switchPasswordHiding() {
        
    }

    
    // MARK: - Private methods
    
    private func setupBottomLine() {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    private func configureByType() {
        
        let leftIconContainer = UIView(frame: Locals.leftImageFrame)
        let leftIcon = UIImageView(frame: Locals.leftImageFrame)
        leftIcon.contentMode = .scaleAspectFit
        
        switch type {
            
        case .email:
            leftIcon.image = Images.email()
            placeholder = "Email"
            
        case .password:
            leftIcon.image = Images.lock()
            isSecureTextEntry = true
            placeholder = "Пароль"
            
        case .firstName:
            leftIcon.image = Images.pencil()
            placeholder = "Имя"
            
        case .lastName:
            leftIcon.image = Images.pencil()
            placeholder = "Фамилия"
        }
        
        leftIconContainer.addSubview(leftIcon)
        leftView = leftIconContainer
        leftViewMode = .always
        
    }
    
    private func setupPlaceholder() {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                NSAttributedString.Key.font: UIFont(name: MainFont.regular, size: 16) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray as Any
            ]
        )
    }
    
}
