//
//  TestListTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestListTableViewManagerDelegate: AnyObject {
    func didTapOnTest(_ test: Test)
}

protocol TestListTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TestListViewModel)
}

final class TestListTableViewManager: NSObject {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let topContentInset: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    weak var delegate: TestListTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: TestListViewModel?
    
}


// MARK: - TestListTableViewManagerInput
extension TestListTableViewManager: TestListTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        tableView.register(CommonTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.top = Locals.topContentInset
        self.tableView = tableView
    }
    
    func update(with viewModel: TestListViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TestListTableViewManager: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = viewModel?.rows[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        cell.selectionStyle = .none
        row.configurator.configure(cell: cell)
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension TestListTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        guard let test = viewModel?.tests[safe: indexPath.row] else {
            return
        }
        
        delegate?.didTapOnTest(test)
    }
}
