//
//  TestQuestionViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestQuestionViewInput: Alertable, TabBarPresentable {
    func update(with viewModel: TestQuestionViewModel)
    func showNotConfirmAlert()
}

final class TestQuestionViewController: UIViewController {
	
    // MARK: - Public properties
    
	var presenter: TestQuestionViewOutput?
    var tableViewManager: TestQuestionTableViewManagerInput?
    
    private let tableView = UITableView()
    private let confirmButton = CommonButton(style: .filled)
    private let finishTestButton = CommonButton(style: .filled)
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }

    
    // MARK: - Private Methods
    
    private func drawSelf() {
    
        view.backgroundColor = Colors.mainBlueColor()
        navigationItem.hidesBackButton = true
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        
        confirmButton.setTitle("Подтвердить", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTap), for: .touchUpInside)
        
        finishTestButton.setTitle("Завершить тест", for: .normal)
        finishTestButton.addTarget(self, action: #selector(finishTap), for: .touchUpInside)
    
        tableViewManager?.setup(tableView: tableView)
        
        view.addSubview(containerView)
        view.addSubview(finishTestButton)
        containerView.addSubview(tableView)
        containerView.addSubview(confirmButton)
        
        tableView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                      excludingEdge: .bottom)
        
        finishTestButton.autoPinEdge(.top, to: .bottom, of: containerView, withOffset: 10)
        finishTestButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20),
                                                      excludingEdge: .top)
        
        confirmButton.autoPinEdge(.top, to: .bottom, of: tableView, withOffset: 10)
        confirmButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20),
                                                   excludingEdge: .top)
    }
    
    
    // MARK: - Actions
    
    @objc private func confirmTap() {
        presenter?.didTapConfirmButton()
    }
    
    @objc private func finishTap() {
        presenter?.didTapFinishButton()
    }
    
}


// MARK: - TestQuestionViewInput
extension TestQuestionViewController: TestQuestionViewInput {
    
    func update(with viewModel: TestQuestionViewModel) {
        title = "Вопрос \(viewModel.currentQuestionNumber)/\(viewModel.questionsCount)"
        tableViewManager?.update(with: viewModel)
    }
    
    func showNotConfirmAlert() {
        // TODO: - From localized
        showAlert(title: "Вы должны выбрать вариант ответа, прежде чем продолжить", buttonTitle: "Oк")
    }
    
}
