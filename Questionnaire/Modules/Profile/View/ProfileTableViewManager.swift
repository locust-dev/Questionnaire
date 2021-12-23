//
//  ProfileTableViewManager.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.12.2021.
//

import UIKit

protocol ProfileTableViewManagerDelegate: AnyObject { }

protocol ProfileTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: ProfileViewModel)
}

final class ProfileTableViewManager: NSObject {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let defaultRowHeight: CGFloat = 50
        static let topContentInset: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    weak var delegate: ProfileTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: ProfileViewModel?
    
}


// MARK: - TestCategoriesTableViewManagerInput
extension ProfileTableViewManager: ProfileTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        tableView.register(ProfileListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        self.tableView = tableView
    }
    
    func update(with viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension ProfileTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = viewModel?.rows[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        row.configurator.configure(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.rows[safe: indexPath.row]?.configurator.cellHeight ?? Locals.defaultRowHeight
    }
    
}


// MARK: - UITableViewDelegate
extension ProfileTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
