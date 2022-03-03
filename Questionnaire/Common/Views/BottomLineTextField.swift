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
            
        static let textInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
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
        textColor = .black
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
        // TODO: - Иконка раскрытия пароля в текс филде
    }

    
    // MARK: - Private methods
    
    private func setupBottomLine() {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    private func setupPlaceholder() {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                NSAttributedString.Key.font: MainFont.regular.withSize(16) as Any,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray as Any
            ]
        )
    }
    
}
