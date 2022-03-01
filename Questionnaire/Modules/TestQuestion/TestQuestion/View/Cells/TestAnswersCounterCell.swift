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
    
    private func createButtonAction(_ button: AnswerButton, isMultipleAnswers: Bool) {
        isMultipleAnswers
            ? button.addTarget(self, action: #selector(selectMultipleAnswers(_:)), for: .touchUpInside)
            : button.addTarget(self, action: #selector(selectOneAnswer(_:)), for: .touchUpInside)
    }
    
    private func createMistakeButton(_ button: AnswerButton,
                                     mistakeModel: QuestionMistakeModel,
                                     answerCount: Int) {
        
        if (mistakeModel.selectedRightAnswers.first(where: { $0 == answerCount })) != nil {
            button.setStyle(.selectedRight)
            
        } else if (mistakeModel.wrongAnswers.first(where: { $0 == answerCount })) != nil {
            button.setStyle(.wrong)
            
        } else if (mistakeModel.missingRightAnswers.first(where: { $0 == answerCount })) != nil {
            button.setStyle(.unselectedRight)
        }
    }
    
    private func createButton(answerCount: Int,
                              title: String,
                              mistakeModel: QuestionMistakeModel?,
                              isMultipleAnswers: Bool) -> AnswerButton {
        
        let answerButton = AnswerButton(answerCount: String(answerCount), title: title)
        answerButton.style = .shadow
        answerButton.tag = answerCount
        
        if let mistakeModel = mistakeModel {
            createMistakeButton(answerButton, mistakeModel: mistakeModel, answerCount: answerCount)
            
        } else {
            createButtonAction(answerButton, isMultipleAnswers: isMultipleAnswers)
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
        let stackSpacing: CGFloat
        let stackInsets: UIEdgeInsets
        let questionMistakeModel: QuestionMistakeModel?
    }
    
    func configure(with model: Model) {
        
        answersStack.spacing = model.stackSpacing
        answersStack.removeAllArrangedSubviewsFully()
        answersStack.autoPinEdgesToSuperviewEdges(with: model.stackInsets)
        
        model.answers.enumerated().forEach { (index, title) in
            
            let answerButton = createButton(answerCount: index + 1,
                                            title: title,
                                            mistakeModel: model.questionMistakeModel,
                                            isMultipleAnswers: model.isMultipleAnswers)
            
            answersStack.addArrangedSubview(answerButton)
        }
    }
    
}
