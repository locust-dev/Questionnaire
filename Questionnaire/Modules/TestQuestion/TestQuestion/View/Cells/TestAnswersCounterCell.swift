//
//  TestAnswersCounterCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import UIKit

final class TestAnswersCounterCell: NLTableViewCell, Delegatable {
    
    // MARK: - Properties
    
    var delegate: AnyObject?
    
    private var selectedAnswers: [Int] = []
    
    private let answersStack = UIStackView()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        
        answersStack.axis = .vertical
        answersStack.distribution = .fillEqually
        
        contentView.addSubview(answersStack)
    }
    
    
    // MARK: - Private methods
    
    private func setAllButtonsUnselected() {
        answersStack.subviews.forEach { view in
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
    }
    
    private func createButton(answerCount: Int, title: String, model: Model) -> AnswerButton {
        
        let answerButton = AnswerButton(title: "\(answerCount). \(title)")
        answerButton.style = .shadow
        answerButton.tag = answerCount
        
        if let rightAnswer = model.rightAnswer, let wrongAnswer = model.wrongAnswer {
            if (rightAnswer.first(where: { $0 == answerCount })) != nil {
                answerButton.setRightAnswerStyle()
                
            } else if (wrongAnswer.first(where: { $0 == answerCount })) != nil {
                answerButton.setWrongAnswerStyle()
            }
            
        } else {
            if model.isMultipleAnswers {
                answerButton.addTarget(self, action: #selector(selectMultipleAnswers(_:)), for: .touchUpInside)
                
            } else {
                answerButton.addTarget(self, action: #selector(selectOneAnswer(_:)), for: .touchUpInside)
            }
        }
        
        return answerButton
    }
    
    
    // MARK: - Actions
    
    @objc private func selectOneAnswer(_ sender: UIButton) {
        setAllButtonsUnselected()
        sender.isSelected = true
        (delegate as? TestQuestionTableViewManagerDelegate)?.didSelectAnswers([sender.tag])
    }
    
    @objc private func selectMultipleAnswers(_ sender: UIButton) {
        
        if sender.isSelected {
            guard let index = selectedAnswers.firstIndex(of: sender.tag) else {
                return
            }
            selectedAnswers.remove(at: index)
            sender.isSelected = false
            
        } else {
            selectedAnswers.append(sender.tag)
            sender.isSelected = true
        }
        
        (delegate as? TestQuestionTableViewManagerDelegate)?.didSelectAnswers(selectedAnswers)
    }
    
}


// MARK: - Configurable
extension TestAnswersCounterCell: Configurable {
    
    struct Model {
        
        let answers: [String]
        let isMultipleAnswers: Bool
        let rightAnswer: [Int]?
        let wrongAnswer: [Int]?
        let stackSpacing: CGFloat
        let stackInsets: UIEdgeInsets
    }
    
    func configure(with model: Model) {
        
        answersStack.spacing = model.stackSpacing
        answersStack.removeAllArrangedSubviewsFully()
        answersStack.autoPinEdgesToSuperviewEdges(with: model.stackInsets)
        
        model.answers.enumerated().forEach { (index, title) in
            
            let answerButton = createButton(answerCount: index + 1, title: title, model: model)
            answersStack.addArrangedSubview(answerButton)
        }
    }
    
}
