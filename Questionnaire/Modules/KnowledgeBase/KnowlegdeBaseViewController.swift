//
//  KnowlegdeBaseViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol KnowlegdeBaseViewInput: AnyObject {
    func showLoader()
    func hideLoader()
}

final class KnowlegdeBaseViewController: UIViewController {
	
    // MARK: - Public properties
    
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
        title = "База знаний"
        navigationController?.largeNavBarTitleAppearance(.white, fontName: MainFont.extraBold, size: 34)
        navigationItem.backButtonTitle = ""
        
        tableViewManager?.setup(tableView: tableView)
        tableView.refreshModuleOutput = presenter
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
}


// MARK: - KnowlegdeBaseViewInput
extension KnowlegdeBaseViewController: KnowlegdeBaseViewInput {
 
    func showLoader() {
        tableView.showLoader()
    }
    
    func hideLoader() {
        tableView.hideLoader()
    }
}
