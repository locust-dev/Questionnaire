//
//  KnowledgeCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.02.2022.
//

import UIKit

final class KnowledgeCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        
        contentView.backgroundColor = Colors.mainGrayColor()
       
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: MainFont.medium, size: 16)
        titleLabel.textColor = .black
        
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        titleLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
    }
    
    func makeBottomCurved() {
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}

extension KnowledgeCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        contentView.layer.cornerRadius = 0
    }
}
