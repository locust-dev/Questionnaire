//
//  CommonTableViewCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 19.12.2021.
//

import UIKit

class CommonTableViewCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let nameLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        
        let arrowImageView = UIImageView(image: Images.rightArrow())
        arrowImageView.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, arrowImageView])
        stack.spacing = 14
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: MainFont.bold, size: 18)
        nameLabel.textColor = Colors.mainBlueColor()
        
        contentView.addSubview(stack)
        
        arrowImageView.autoSetDimension(.width, toSize: 30)
        stack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 6))
    }
    
}


// MARK: - Configurable
extension CommonTableViewCell: Configurable {
    
    struct Model {
        
        let name: String
    }
    
    func configure(with model: Model) {
        
        nameLabel.text = model.name
    }
}
