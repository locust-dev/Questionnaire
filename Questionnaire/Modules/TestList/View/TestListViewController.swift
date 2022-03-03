//
//  TestListViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestListViewInput: Alertable, ErrorPresentable {
    func update(with viewModel: TestListViewModel)
    func showAlertIfNoQuestionsInTest()
    func showAlertSureToStartTest(_ test: Test)
    func showLoader()
    func hideLoader()
}

final class TestListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: TestListViewOutput?
    var tableViewManager: TestListTableViewManagerInput?
    
    private let tableView = CommonTableView()
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        
        tableViewManager?.setup(tableView: tableView)
        tableView.refreshModuleOutput = presenter
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
}


// MARK: - TestListViewInput
extension TestListViewController: TestListViewInput {
    
    func update(with viewModel: TestListViewModel) {
        tableViewManager?.update(with: viewModel)
    }
    
    func showAlertIfNoQuestionsInTest() {
        showAlert(title: Localized.alertError(),
                  message: Localized.alertCanNotFindAnyQuestionInTest(),
                  buttonTitle: Localized.buttonOkTitle())
    }
    
    func showAlertSureToStartTest(_ test: Test) {
        
        let okAction = AlertAction(title: Localized.alertStartAction(), style: .default) {
            self.presenter?.didTapStartTest(test)
        }
        
        let cancelAction = AlertAction(title: Localized.alertCancelAction(), style: .cancel)
        
        showAlert(title: Localized.alertBeginTestMainTitle(),
                  message: Localized.alertBeginTestSubtitle(),
                  actions: [okAction, cancelAction])
    }
    
    func showLoader() {
        tableView.showLoader()
    }
    
    func hideLoader() {
        tableView.hideLoader()
    }
    
}

