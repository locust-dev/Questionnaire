//
//  TestResultMistakesCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 20.12.2021.
//

import UIKit

final class TestResultMistakesCell: NLTableViewCell, Delegatable {
    
    // MARK: - Properties
    
    var delegate: AnyObject?
    
    private let titleLabel = UILabel()
    private let mistakesNumbersStack = UIStackView()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        mistakesNumbersStack.spacing = 10
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: MainFont.regular, size: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(mistakesNumbersStack)
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
        
        scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), excludingEdge: .top)
        scrollView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        scrollView.autoSetDimension(.height, toSize: 50)
        
        mistakesNumbersStack.autoPinEdgesToSuperviewEdges()
        
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapMistake(_ sender: UIButton) {
        (delegate as? TestResultTableViewManagerDelegate)?.didSelectQuestionWithMistake(by: sender.tag)
    }
    
}


// MARK: - Configurable
extension TestResultMistakesCell: Configurable {
    
    struct Model {
        
        let mistakesNumbers: [Int]
    }
    
    func configure(with model: Model) {
        
        if model.mistakesNumbers.isEmpty {
            titleLabel.text = "Вы не совершили ни одной ошибки."
            
        } else {
            titleLabel.text = "Вы совершили ошибки в вопросах:"
        }
        
        
        for mistake in model.mistakesNumbers {
            
            let mistakeButton = CommonButton(style: .filled)
            mistakeButton.setTitle(String(mistake), for: .normal)
            mistakeButton.autoSetDimensions(to: CGSize(width: 50, height: 50))
            mistakeButton.layer.cornerRadius = 6
            mistakeButton.tag = mistake
            mistakeButton.addTarget(self, action: #selector(didTapMistake(_:)), for: .touchUpInside)
            mistakesNumbersStack.addArrangedSubview(mistakeButton)
        }
    }
    
}
