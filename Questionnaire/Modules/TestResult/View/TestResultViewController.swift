//
//  TestResultViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestResultViewInput: ErrorPresentable, TabBarPresentable {
    func update(with viewModel: TestResultViewModel)
    func showLoader()
    func hideLoader()
}

final class TestResultViewController: UIViewController {
    
    // MARK: - Pproperties
    
    var presenter: TestResultViewOutput?
    var tableViewManager: TestResultTableViewManagerInput?
    
    private let tableView = CommonTableView()
    private let finishButton = CommonButton(style: .shadow)
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        setupNavBarAppearance()
        
        tableViewManager?.setup(tableView: tableView)
        tableView.layer.cornerRadius = 12
        tableView.loaderColor = Colors.mainBlueColor()
        
        finishButton.setTitle("Завершить тест", for: .normal)
        finishButton.addTarget(self, action: #selector(finishTest), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(finishButton)
        
        finishButton.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20), excludingEdge: .top)
        tableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    // MARK: - Actions
    
    @objc private func finishTest() {
        presenter?.didTapFinishButton()
    }
    
    
    // MARK: - Public methods
    
    func didTapErrorPlaceholderOkButton() {
        presenter?.didTapOkErrorButton()
    }
    
    
    // MARK: - Private methods
    
    private func setupNavBarAppearance() {
        let navigationController = navigationController as? CommonNavigationController
        navigationController?.largeNavBarTitleAppearance(.white, fontName: MainFont.extraBold, size: 34)
        navigationItem.hidesBackButton = true
        navigationItem.backButtonTitle = ""
        title = "Результаты"
    }
    
}


// MARK: - TestResultViewInput
extension TestResultViewController: TestResultViewInput {
    
    func update(with viewModel: TestResultViewModel) {
        tableViewManager?.update(with: viewModel)
    }
    
    func showLoader() {
        tableView.showLoader()
    }
    
    func hideLoader() {
        tableView.hideLoader()
    }
    
}
