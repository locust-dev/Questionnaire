//
//  KnowlegdeHeaderCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.02.2022.
//

import UIKit

protocol KnowledgeHeaderCellDelegate: AnyObject {
    func didTapHeaderCell(at index: Int)
}

final class KnowlegdeHeaderCell: NLTableViewHeaderFooterView {
    
    // MARK: - Properties
    
    weak var delegate: KnowledgeHeaderCellDelegate?
    
    private var sectionIndex: Int?
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: MainFont.bold, size: 18)
        titleLabel.textColor = Colors.mainBlueColor()
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Actions
    
    @objc func tap() {
        
        guard let index = sectionIndex else {
            return
        }
        
        delegate?.didTapHeaderCell(at: index)
    }
    
}

extension KnowlegdeHeaderCell: Configurable {
    
    struct Model {
        
        let title: String
        let sectionIndex: Int
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        sectionIndex = model.sectionIndex
    }
}
