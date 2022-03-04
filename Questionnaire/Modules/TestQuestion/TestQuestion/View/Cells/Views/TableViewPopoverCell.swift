//
//  TableViewPopoverCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 04.03.2022.
//

import UIKit

final class TableViewPopoverCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        contentView.backgroundColor = .white
    
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = MainFont.regular.withSize(16)
        
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
    }
 
}


// MARK: - Configurable
extension TableViewPopoverCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
    }
}
