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
    private let showMistakesButton = CommonButton(style: .filled)
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        titleLabel.textColor = .black
        titleLabel.font = MainFont.regular.withSize(16)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        showMistakesButton.addTarget(self, action: #selector(showMistakes), for: .touchUpInside)
        showMistakesButton.setTitle(Localized.testResultShowMistake(), for: .normal)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(showMistakesButton)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
        
        showMistakesButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), excludingEdge: .top)
        showMistakesButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
    }
    
    
    // MARK: - Actions
    
    @objc private func showMistakes() {
        (delegate as? TestResultTableViewManagerDelegate)?.didTapShowMistakes()
    }
    
}


// MARK: - Configurable
extension TestResultMistakesCell: Configurable {
    
    struct Model {
        
        let mistakesCount: Int
        let titleText: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.titleText
    }
    
}
