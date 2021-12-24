//
//  UITextField+Style.swift
//  Questionnaire
//
//  Created by Ilya Turin on 24.12.2021.
//

import UIKit

extension UITextField {
    
    // MARK: - Locals
    
    private enum Locals {
            
        static let leftImageFrame = CGRect(x: 0, y: 0, width: 20, height: 20)
        static let textInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    }
    
    
    // MARK: - Types
    
    enum TextFieldStyle {
        
        case email
        case password
        case firstName
        case lastName
    }
    
    
    // MARK: - Public methods
    
    func setStyle(_ style: TextFieldStyle) {
        
        let leftIconContainer = UIView(frame: Locals.leftImageFrame)
        let leftIcon = UIImageView(frame: Locals.leftImageFrame)
        leftIcon.contentMode = .scaleAspectFit
        
        switch style {
            
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
    
}
