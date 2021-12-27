//
//  ArrowButton.swift
//  Questionnaire
//
//  Created by Ilya Turin on 27.12.2021.
//

import UIKit

final class ArrowButton: NLButton {
    
    // MARK: - Types
    
    enum ButtonDirection {
        
        case left
        case right
    }
    
    
    // MARK: - Properties
    
    var direction: ButtonDirection {
        didSet {
            drawSelf()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? drawSelf() : setImage(nil, for: .normal)
        }
    }
    
    
    // MARK: - Init
    
    init(direction: ButtonDirection) {
        self.direction = direction
        super.init(frame: .zero)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        imageView?.contentMode = .scaleAspectFit
        
        let image: UIImage?
        
        switch direction {
            
        case .left:
            image = Images.leftArrow()
            
        case .right:
            image = Images.rightArrow()
        }
        
        setImage(image, for: .normal)
    }
    
}
