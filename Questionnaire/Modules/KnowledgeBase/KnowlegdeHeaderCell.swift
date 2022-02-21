//
//  KnowlegdeHeaderCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.02.2022.
//

import UIKit

final class KnowlegdeHeaderCell: NLTableViewHeaderFooterView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        titleLabel.text = "DDD"
        
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges()
    }
}

extension KnowlegdeHeaderCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
    }
}
