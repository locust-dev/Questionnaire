//
//  CommonButton.swift
//  Questionnaire
//
//  Created by Ilya Turin on 18.12.2021.
//

import UIKit

class CommonButton: NLButton {
    
    // MARK: - Types
    
    enum Style {
        
        case filled
        case reversedFilled
        case shadow
        case reversedShadow
    }
    
    
    // MARK: - Properties
    
    var style: Style {
        didSet {
            drawSelf()
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        style = .filled
        super.init(frame: frame)
        drawSelf()
    }
    
    convenience init(style: Style) {
        self.init(frame: .zero)
        self.style = style
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        autoSetDimension(.height, toSize: 50)
        
        switch style {
            
        case .filled:
            backgroundColor = Colors.mainBlueColor()
            setTitleColor(.white, for: .normal)
            
        case .reversedFilled:
            backgroundColor = .white
            setTitleColor(Colors.mainBlueColor(), for: .normal)
            
        case .shadow:
            backgroundColor = .white
            layer.borderColor = Colors.mainBlueColor()?.cgColor
            layer.borderWidth = 1.5
            setTitleColor(Colors.mainBlueColor(), for: .normal)
            
        case .reversedShadow:
            backgroundColor = Colors.mainBlueColor()
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 1.5
            setTitleColor(.white, for: .normal)
            
        }
        
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: MainFont.bold, size: 16)
    }
    
}
