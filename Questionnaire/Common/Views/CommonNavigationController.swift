//
//  CommonNavigationController.swift
//  Questionnaire
//
//  Created by Ilya Turin on 19.12.2021.
//

import UIKit

final class CommonNavigationController: UINavigationController {
    
    // MARK: - Init
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        setBackButtonDesign()
    }
    
    
    // MARK: - Public methods
    
    func largeNavBarTitleAppearance(_ color: UIColor, fontName: String, size: CGFloat) {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: fontName, size: size)
        ]
        
        navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
}
