//
//  MainFont.swift
//  Questionnaire
//
//  Created by Ilya Turin on 24.12.2021.
//

import UIKit

enum MainFont {
    
    // MARK: - Types
    
    case bold
    case extraBold
    case medium
    case regular
    
    enum FontName {
        
        static let regular = "Nunito-Regular"
        static let medium = "Nunito-Medium"
        static let bold = "Nunito-Bold"
        static let extraBold = "Nunito-ExtraBold"
    }
    
    
    // MARK: - Public methods
    
    func withSize(_ size: CGFloat) -> UIFont {
        
        var font: UIFont?

        switch self {
            
        case .bold:
            font = UIFont(name: FontName.bold, size: size)
            
        case .extraBold:
            font = UIFont(name: FontName.extraBold, size: size)
            
        case .medium:
            font = UIFont(name: FontName.medium, size: size)
            
        case .regular:
            font = UIFont(name: FontName.regular, size: size)
        }
        
        return font ?? UIFont.systemFont(ofSize: 16)
    }
}
