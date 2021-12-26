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
    
    
    // MARK: - Private methods
    
    private func setAllButtonsUnselected() {
        answersStack.subviews.forEach { view in
            if let button = view as? UIButton {
                button.isSelected = false
            }
        }
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
    }
    
    func configure(with model: Model) {
        
        answersStack.removeAllArrangedSubviewsFully()
        
        model.answers.enumerated().forEach { (index, title) in
            
            let answerCount = index + 1
            let answerButton = AnswerButton(title: "\(answerCount). \(title)")
            answerButton.style = .shadow
            answerButton.tag = answerCount
            
            if model.isMultipleAnswers {
                answerButton.addTarget(self, action: #selector(selectMultipleAnswers(_:)), for: .touchUpInside)
            } else {
                answerButton.addTarget(self, action: #selector(selectOneAnswer(_:)), for: .touchUpInside)
            }
            
            answersStack.addArrangedSubview(answerButton)
        }
    }
    
}
