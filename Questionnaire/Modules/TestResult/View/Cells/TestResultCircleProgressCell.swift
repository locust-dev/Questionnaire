//
//  TestResultCircleProgressCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 20.12.2021.
//

import UIKit

final class TestResultCircleProgressCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let progressCircleView = CircularProgressBarView()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        titleLabel.textColor = .black
        titleLabel.font =  MainFont.regular.withSize(20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(progressCircleView)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 40, right: 20), excludingEdge: .top)
        containerView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 40)
        containerView.autoSetDimension(.height, toSize: progressCircleView.diameter)
        
        progressCircleView.autoCenterInSuperview()
    }
}


// MARK: - Configurable
extension TestResultCircleProgressCell: Configurable {
    
    struct Model {
        
        let progressPercent: Double
        let titleText: String
    }
    
    func configure(with model: Model) {
        progressCircleView.start(duration: 2, percentage: model.progressPercent)
        titleLabel.text = model.titleText
    }
    
}
