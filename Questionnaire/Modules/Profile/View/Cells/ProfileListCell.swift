//
//  ProfileListCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.12.2021.
//

import UIKit
import SwiftUI

final class ProfileListCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        titleLabel.font = UIFont(name: MainFont.medium, size: 18)
        titleLabel.textColor = .black
        
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20))
    }
    
}


// MARK: - Configurable
extension ProfileListCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        
        titleLabel.text = model.title
    }
}
