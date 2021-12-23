//
//  Constants.swift
//  Questionnaire
//
//  Created by Ilya Turin on 09.12.2021.
//

import UIKit

typealias Colors = R.color
typealias Images = R.image

enum Fonts {
    
    // MARK: - Types
    
    enum SansDisplayWeight {
        
        case bold
        case semibold
        case light
        case regular
        case thin
        
    }
    
    enum SansDisplayStyle {
        
        /// SBSansDisplay-Semibold size 34
        case semiboldTitle
        
        /// SBSansDisplay-Semibold size 24
        case semiboldH2
        
        /// SBSansDisplay-Semibold size 17
        case semiboldH1
        
        /// SBSansDisplay-Regular size 34
        case regularH0
        
        /// SBSansDisplay-Regular size 32
        case regularH1
        
        /// SBSansDisplay-Regular size 24
        case regularH2
        
        /// SBSansDisplay-Regular size 22
        case regularH3
        
        /// SBSansDisplay-Regular size 19
        case regularLarge
        
        /// SBSansDisplay-Regular size 17
        case regularDefault
        
        /// SBSansDisplay-Regular size 15
        case regularMedium
        
        /// SBSansDisplay-Regular size 14
        case regularMediumBody
        
        /// SBSansDisplay-Regular size 13
        case regularSmallBody
        
        /// SBSansDisplay-Regular size 12
        case regularSmall
        
    }
    
    
    // MARK: - Cases
    
    case sansDisplayStyle(_ style: SansDisplayStyle)
    
    case sansDisplay(fontSize: CGFloat, weight: SansDisplayWeight = .regular)
    
    case system(fontSize: CGFloat, weight: UIFont.Weight)
    
    
    // MARK: - Properties
    
    var font: UIFont {
        
        switch self {
        
        case .sansDisplayStyle(let style):
            let fontName: String
            let fontSize: CGFloat
            
            switch style {
            
            case .semiboldTitle:
                fontName = "SBSansDisplay-Semibold"
                fontSize = 34
                
            case .semiboldH2:
                fontName = "SBSansDisplay-Semibold"
                fontSize = 24
                
            case .semiboldH1:
                fontName = "SBSansDisplay-Semibold"
                fontSize = 17
                
            case .regularH0:
                fontName = "SBSansDisplay-Regular"
                fontSize = 34
                
            case .regularH1:
                fontName = "SBSansDisplay-Regular"
                fontSize = 32
                
            case .regularH2:
                fontName = "SBSansDisplay-Regular"
                fontSize = 24
                
            case .regularH3:
                fontName = "SBSansDisplay-Regular"
                fontSize = 22
                
            case .regularLarge:
                fontName = "SBSansDisplay-Regular"
                fontSize = 19
                
            case .regularDefault:
                fontName = "SBSansDisplay-Regular"
                fontSize = 17
                
            case .regularMedium:
                fontName = "SBSansDisplay-Regular"
                fontSize = 15
                
            case .regularMediumBody:
                fontName = "SBSansDisplay-Regular"
                fontSize = 14
                
            case .regularSmallBody:
                fontName = "SBSansDisplay-Regular"
                fontSize = 13
                
            case .regularSmall:
                fontName = "SBSansDisplay-Regular"
                fontSize = 12
                
            }
            
            return UIFont(name: fontName, size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .regular)
        
        case .sansDisplay(let size, let weight):
            let fontName: String
            
            switch weight {
            
            case .bold:
                fontName = "SBSansDisplay-Bold"
                
            case .semibold:
                fontName = "SBSansDisplay-Semibold"
                
            case .light:
                fontName = "SBSansDisplay-Light"
                
            case .regular:
                fontName = "SBSansDisplay-Regular"
                
            case .thin:
                fontName = "SBSansDisplay-Thin"
                
            }
            
            return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size, weight: .regular)
        
        case .system(let fontSize, let weight):
            return .systemFont(ofSize: fontSize, weight: weight)
            
        }
    }
    
}
