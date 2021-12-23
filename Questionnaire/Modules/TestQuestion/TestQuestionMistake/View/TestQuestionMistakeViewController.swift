//
//  TestQuestionMistakeViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestQuestionMistakeViewInput: AnyObject {
    func update(with viewModel: TestQuestionMistakeViewModel)
}

final class TestQuestionMistakeViewController: UIViewController {
	
    // MARK: - Public properties
    
	var presenter: TestQuestionMistakeViewOutput?
    var tableViewManager: TestQuestionMistakeTableViewManagerInput?
    
    private let tableView = CommonTableView()
    private let questionCountLabel = UILabel()
    private let closeButton = UIButton()
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Private Methods
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        
        closeButton.setImage(Images.closeButton(), for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        questionCountLabel.font = UIFont(name: MainFont.extraBold, size: 34)
        questionCountLabel.textColor = .white
        
        tableViewManager?.setup(tableView: tableView)
        
        view.addSubview(containerView)
        view.addSubview(questionCountLabel)
        view.addSubview(closeButton)
        containerView.addSubview(tableView)
        
        closeButton.autoAlignAxis(.horizontal, toSameAxisOf: questionCountLabel)
        closeButton.autoPinEdge(.right, to: .right, of: view, withOffset: -20)
        closeButton.autoSetDimensions(to: CGSize(width: 20, height: 20))
        
        questionCountLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
        
        containerView.autoPinEdge(.top, to: .bottom, of: questionCountLabel, withOffset: 20)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10), excludingEdge: .top)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapCloseButton() {
        presenter?.didTapCloseButton()
    }
    
}


// MARK: - TestQuestionMistakeViewInput
extension TestQuestionMistakeViewController: TestQuestionMistakeViewInput {
    
    func update(with viewModel: TestQuestionMistakeViewModel) {
        questionCountLabel.text = "Вопрос \(viewModel.currentQuestionNumber)/\(viewModel.questionsCount)"
        tableViewManager?.update(with: viewModel)
    }
}
