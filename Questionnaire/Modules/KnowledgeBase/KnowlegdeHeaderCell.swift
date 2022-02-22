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
    private var numberOfSections: Int?
    
    var isExpanded = false {
        didSet {
            setCornerRadiusForLastSection()
        }
    }
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: MainFont.bold, size: 18)
        titleLabel.textColor = Colors.mainBlueColor()
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = Colors.mainGrayColor()
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomLine)
        
        bottomLine.autoSetDimension(.height, toSize: 1)
        bottomLine.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), excludingEdge: .top)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        titleLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
    }
    
    
    // MARK: - Actions
    
    @objc func tap() {
        
        guard let index = sectionIndex else {
            return
        }

        isExpanded.toggle()
        delegate?.didTapHeaderCell(at: index)
    }
    
    
    // MARK: - Private methods
    
    private func setCornerRadiusForLastSection() {

        guard let numberOfSections = numberOfSections,
              let sectionIndex = sectionIndex,
              sectionIndex == numberOfSections - 1
        else {
            return
        }

        contentView.layer.cornerRadius = isExpanded ? 0 : 10
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}

extension KnowlegdeHeaderCell: Configurable {
    
    struct Model {
        
        let title: String
        let sectionIndex: Int
        let numberOfSections: Int
    }
    
    func configure(with model: Model) {
        
        titleLabel.text = model.title
        sectionIndex = model.sectionIndex
        numberOfSections = model.numberOfSections
        
        if sectionIndex == 0 {
            contentView.layer.cornerRadius = 10
            contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
        } else if sectionIndex == model.numberOfSections - 1 {
            setCornerRadiusForLastSection()
        }
    }
}
