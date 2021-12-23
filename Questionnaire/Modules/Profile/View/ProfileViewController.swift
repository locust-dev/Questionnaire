//
//  ProfileViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol ProfileViewInput: Loadable, Alertable  {
    func update(with viewModel: ProfileViewModel)
}

final class ProfileViewController: UIViewController {
	
    // MARK: - Properties
    
	var presenter: ProfileViewOutput?
    var tableViewManager: ProfileTableViewManagerInput?
    
    private let logOutButton = CommonButton(style: .filled)
    private let tableView = CommonTableView()
    
    
    // MARK: - Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        setupNavBarAppearance()
        
        tableViewManager?.setup(tableView: tableView)
        
        logOutButton.addTarget(self, action: #selector(logOutTap), for: .touchUpInside)
        
        view.addSubview(logOutButton)
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        logOutButton.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), excludingEdge: .top)
        logOutButton.autoPinEdge(.top, to: .bottom, of: tableView)
    }
    
    
    // MARK: - Actions
    
    @objc private func logOutTap() {
        presenter?.didTapLogOutButton()
    }
    
    
    // MARK: - Private methods
    
    private func setupNavBarAppearance() {
        let navigationController = navigationController as? CommonNavigationController
        navigationController?.largeNavBarTitleAppearance(.black, fontName: MainFont.extraBold, size: 34)
    }
    
}


// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    
    func update(with viewModel: ProfileViewModel) {
        
        title = viewModel.fullName
    
        // TODO: - From localized
        logOutButton.setTitle("Выйти", for: .normal)
        tableViewManager?.update(with: viewModel)
    }
    
}
