//
//  CodeSampleCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 01.03.2022.
//

import UIKit
import SDWebImage

final class CodeSampleCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let codeSampleImage = ResizableAsyncImageView()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        codeSampleImage.contentMode = .scaleAspectFit
        
        contentView.addSubview(codeSampleImage)
        codeSampleImage.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    }
    
}


// MARK: - Configurable
extension CodeSampleCell: Configurable {
    
    struct Model {
        
        let codeSampleImagePath: String
    }
    
    func configure(with model: Model) {
        self.codeSampleImage.sd_setImage(with: URL(string: model.codeSampleImagePath)) { _, _, _, _ in

            // ОБЯЗАТЕЛЬНО ИЗУЧИТЬ
            if let superview = self.superview as? UITableView {
                superview.beginUpdates()
                superview.endUpdates()
            }
        }
    }
    
}
