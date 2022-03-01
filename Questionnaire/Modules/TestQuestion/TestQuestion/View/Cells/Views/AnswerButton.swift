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
    private let answerCountLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    
    
    // MARK: - Types
    
    enum AnswerStyle {
        
        case wrong
        case selectedRight
        case unselectedRight
    }
    
    
    // MARK: - Init
    
    init(answerCount: String, title: String) {
        super.init(frame: .zero)
        mainTitleLabel.text = title
        answerCountLabel.text = answerCount
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
    
        checkmarkImageView.image = Images.reverserDeselectedCircle()
        checkmarkImageView.contentMode = .scaleAspectFit
        
        mainTitleLabel.numberOfLines = 0
        mainTitleLabel.font = UIFont(name: MainFont.bold, size: 16)
        mainTitleLabel.textColor = Colors.mainBlueColor()
        
        answerCountLabel.font = UIFont(name: MainFont.bold, size: 16)
        answerCountLabel.textColor = Colors.mainBlueColor()
        
        let stack = UIStackView(arrangedSubviews: [answerCountLabel, mainTitleLabel, checkmarkImageView])
        stack.spacing = 12
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        
        addSubview(stack)
        stack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 12))
        checkmarkImageView.autoSetDimensions(to: CGSize(width: 20, height: 20))
    }
    
    
    // MARK: - Public methods
    
    func setStyle(_ style: AnswerStyle) {
        
        switch style {
            
        case .wrong:
            backgroundColor = Colors.wrongAnswer()
            checkmarkImageView.image = Images.selectedCirlce()
            
        case .selectedRight:
            backgroundColor = Colors.rightAnswer()
            checkmarkImageView.image = Images.selectedCirlce()
            
        case .unselectedRight:
            backgroundColor = Colors.rightAnswer()
            checkmarkImageView.image = Images.deselectedCirlce()
        }
        
        layer.borderWidth = 0
        mainTitleLabel.textColor = .white
        answerCountLabel.textColor = .white
    }
    

    // MARK: - Private methods
    
    private func setStyle() {
        
        switch isSelected {
            
        case true:
            style = .filled
            checkmarkImageView.image = Images.selectedCirlce()
            mainTitleLabel.textColor = .white
            answerCountLabel.textColor = .white
            
        case false:
            style = .shadow
            checkmarkImageView.image = Images.reverserDeselectedCircle()
            mainTitleLabel.textColor = Colors.mainBlueColor()
            answerCountLabel.textColor = Colors.mainBlueColor()
        }
    }
    
}
