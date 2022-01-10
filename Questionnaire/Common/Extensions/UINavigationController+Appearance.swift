//
//  UINavigationController+Appearance.swift
//  Questionnaire
//
//  Created by Ilya Turin on 20.12.2021.
//

import UIKit

extension UINavigationController {
    
    func largeNavBarTitleAppearance(_ color: UIColor, fontName: String, size: CGFloat) {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: fontName, size: size)
        ]
        
        navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
}
