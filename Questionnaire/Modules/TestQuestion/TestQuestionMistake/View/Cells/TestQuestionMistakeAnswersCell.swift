//
//  TestQuestionMistakeAnswersCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import UIKit

final class TestQuestionMistakeAnswersCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let answersStack = UIStackView()
 
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 30, bottom: 8, right: 30))
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
    
        backgroundColor = .clear
        
        answersStack.axis = .vertical
        answersStack.spacing = 20
        answersStack.distribution = .fillEqually
        
        contentView.addSubview(answersStack)
        answersStack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
    }
    
}


// MARK: - Configurable
extension TestQuestionMistakeAnswersCell: Configurable {
    
    struct Model {
        
        let answers: [String]
        let rightAnswer: Int
        let wrongAnswer: Int
    }
    
    func configure(with model: Model) {
        
        answersStack.removeAllArrangedSubviewsFully()
        
        model.answers.enumerated().forEach { (index, title) in
            
            let answerCount = index + 1
            let answerButton = AnswerButton(title: "\(answerCount). \(title)")
            answerButton.style = .shadow
            answersStack.addArrangedSubview(answerButton)
            
            if answerCount == model.rightAnswer {
                answerButton.setRightAnswerStyle()
            } else if answerCount == model.wrongAnswer {
                answerButton.setWrongAnswerStyle()
            }
        }
    }
    
}
