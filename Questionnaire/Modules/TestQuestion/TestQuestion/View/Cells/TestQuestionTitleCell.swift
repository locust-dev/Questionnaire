//
//  TestQuestionTitleCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import UIKit

final class TestQuestionTitleCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    
        titleLabel.numberOfLines = 0
        titleLabel.font = MainFont.regular.withSize(16)
        titleLabel.textColor = .black
        
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 30, left: 30, bottom: 10, right: 30))
    }
    
    
}


// MARK: - Configurable
extension TestQuestionTitleCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        
        titleLabel.text = model.title
    }
}
