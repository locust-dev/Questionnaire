//
//  TestQuestionExplanationCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 03.03.2022.
//

import UIKit

final class TestQuestionExplanationCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let explanationLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        explanationLabel.numberOfLines = 0
        explanationLabel.textColor = .black
        explanationLabel.font = MainFont.regular.withSize(18)
        
        contentView.addSubview(explanationLabel)
        explanationLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
    }
    
}


// MARK: - Configurable
extension TestQuestionExplanationCell: Configurable {
    
    struct Model {
        
        let explanationText: String
    }
    
    func configure(with model: Model) {
        
        explanationLabel.text = model.explanationText
    }
}
