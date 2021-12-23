//
//  TestCategoriesViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestCategoriesViewInput: Alertable, ErrorPresentable {
    func update(with viewModel: TestCategoriesViewModel)
    func showNonAuthorizedAlert()
    func showLoader()
    func hideLoader()
}

final class TestCategoriesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: TestCategoriesViewOutput?
    var tableViewManager: TestCategoriesTableViewManagerInput?
    
    private let tableView = CommonTableView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        title = "Категории"
        tabBarItem.title = "Тесты"
        setupNavBarAppearance()
        
        view.backgroundColor = Colors.mainBlueColor()
        
        tableViewManager?.setup(tableView: tableView)
        tableView.refreshModuleOutput = presenter
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    
    // MARK: - Private methods
    
    private func setupNavBarAppearance() {
        let navigationController = navigationController as? CommonNavigationController
        navigationController?.largeNavBarTitleAppearance(.white, fontName: MainFont.extraBold, size: 34)
        navigationItem.backButtonTitle = ""
    }
    
}


// MARK: - TestCategoriesViewInput
extension TestCategoriesViewController: TestCategoriesViewInput {
    
    func update(with viewModel: TestCategoriesViewModel) {
        tableViewManager?.update(with: viewModel)
    }
    
    func showNonAuthorizedAlert() {
        // TODO: - From config
        showAlert(title: "Вы должны авторизоваться, чтобы начать проходить тесты", buttonTitle: "Ok")
    }
    
    func showLoader() {
        tableView.showLoader()
    }
    
    func hideLoader() {
        tableView.hideLoader()
    }
}
