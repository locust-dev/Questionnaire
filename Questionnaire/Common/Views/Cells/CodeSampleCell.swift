//
//  CodeSampleCell.swift
//  Questionnaire
//
//  Created by Ilya Turin on 01.03.2022.
//

import UIKit
import SDWebImage

protocol CodeSampleCellDelegate: AnyObject {
    func didTapImage(_ image: UIImage)
}

final class CodeSampleCell: NLTableViewCell, Delegatable {
    
    // MARK: - Properties
    
    weak var delegate: AnyObject?
    
    private let codeSampleImage = ResizableAsyncImageView()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        codeSampleImage.isUserInteractionEnabled = true
        codeSampleImage.contentMode = .scaleAspectFit
        codeSampleImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTap)))
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(codeSampleImage)
        codeSampleImage.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    }
    
    
    // MARK: - Actions
    
    @objc private func imageTap() {
        
        guard let image = codeSampleImage.image else {
            return
        }
        
        (delegate as? CodeSampleCellDelegate)?.didTapImage(image)
    }
    
}


// MARK: - Configurable
extension CodeSampleCell: Configurable {
    
    struct Model {
        
        let codeSampleImagePath: String
    }
    
    func configure(with model: Model) {
        
        self.codeSampleImage.sd_setImage(with: URL(string: model.codeSampleImagePath)) { [superview] _, _, _, _ in
            let tableView = superview as? UITableView
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
    }
    
}
