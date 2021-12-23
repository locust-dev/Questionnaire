//
//  AnswerView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import UIKit

final class AnswerButton: CommonButton {
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            setStyle()
        }
    }
   
    private let mainTitleLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    
    
    // MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        mainTitleLabel.text = title
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        checkmarkImageView.image = Images.reverserDeselectedCircle()
        checkmarkImageView.contentMode = .scaleAspectFit
        
        mainTitleLabel.font = UIFont(name: MainFont.bold, size: 16)
        mainTitleLabel.textColor = Colors.mainBlueColor()
        
        let stack = UIStackView(arrangedSubviews: [mainTitleLabel, checkmarkImageView])
        stack.spacing = 14
        stack.isUserInteractionEnabled = false
        
        addSubview(stack)
        stack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20))
        checkmarkImageView.autoSetDimensions(to: CGSize(width: 20, height: 20))
    }
    
    
    // MARK: - Public methods
    
    func setRightAnswerStyle() {
        backgroundColor = Colors.rightAnswer()
        mainTitleLabel.textColor = .white
        checkmarkImageView.image = Images.deselectedCirlce()
        layer.borderWidth = 0
    }
    
    func setWrongAnswerStyle() {
        backgroundColor = Colors.wrongAnswer()
        mainTitleLabel.textColor = .white
        checkmarkImageView.image = Images.selectedCirlce()
        layer.borderWidth = 0
    }
    
    
    // MARK: - Private methods
    
    private func setStyle() {
        
        switch isSelected {
            
        case true:
            style = .filled
            checkmarkImageView.image = Images.selectedCirlce()
            mainTitleLabel.textColor = .white
            
        case false:
            style = .shadow
            checkmarkImageView.image = Images.reverserDeselectedCircle()
            mainTitleLabel.textColor = Colors.mainBlueColor()
        }
    }
    
}
