//
//  KnowlegdeBaseViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol KnowlegdeBaseViewInput: ErrorPresentable {
    
    var delegate: KnowledgeBaseContainerViewControllerDelegate? { get set }
    
    func update(with viewModel: KnowlegdeBaseViewModel)
    func showLoader()
    func hideLoader()
    func closeAllSections()
    func setHiddenSectionsButton(_ isHidden: Bool)
}

final class KnowlegdeBaseViewController: UIViewController {
	
    // MARK: - Public properties
    
    weak var delegate: KnowledgeBaseContainerViewControllerDelegate?
    
	var presenter: KnowlegdeBaseViewOutput?
    var tableViewManager: KnowlegdeBaseTableViewManagerInput?
    
    private let tableView = CommonTableView()
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Private Methods
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        
        tableViewManager?.setup(tableView: tableView)
        tableView.refreshModuleOutput = presenter
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
}


// MARK: - KnowlegdeBaseViewInput
extension KnowlegdeBaseViewController: KnowlegdeBaseViewInput {
    
    func setHiddenSectionsButton(_ isHidden: Bool) {
        delegate?.setHiddenSectionsButton(isHidden)
    }
    
    func closeAllSections() {
        tableViewManager?.didTapCloseAllSections()
    }
    
    func update(with viewModel: KnowlegdeBaseViewModel) {
        tableViewManager?.update(with: viewModel)
    }
 
    func showLoader() {
        tableView.showLoader()
    }
    
    func hideLoader() {
        tableView.hideLoader()
    }
}
