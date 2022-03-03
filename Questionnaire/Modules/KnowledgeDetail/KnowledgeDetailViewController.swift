//
//  KnowledgeDetailViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol KnowledgeDetailViewInput: AnyObject {
    func update(with viewModel: KnowledgeDetailViewModel)
}

final class KnowledgeDetailViewController: UIViewController {
	
    // MARK: - Public properties
    
	var presenter: KnowledgeDetailViewOutput?
    
    private let textView = UITextView()
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawning
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        textView.isEditable = false
        textView.textColor = .black
        textView.font = MainFont.regular.withSize(14)
        
        view.addSubview(textView)
        textView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
    }
    
}


// MARK: - KnowledgeDetailViewInput
extension KnowledgeDetailViewController: KnowledgeDetailViewInput {
    
    func update(with viewModel: KnowledgeDetailViewModel) {
        title = viewModel.title
        textView.text = viewModel.text
    }
}
