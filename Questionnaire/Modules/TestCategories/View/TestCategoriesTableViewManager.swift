//
//  TestCategoriesTableViewManager.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import UIKit

protocol TestCategoriesTableViewManagerDelegate: AnyObject {
    func didSelectItem(by categoryId: String)
}

protocol TestCategoriesTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TestCategoriesViewModel)
}

final class TestCategoriesTableViewManager: NSObject {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let defaultRowHeight: CGFloat = 90
        static let topContentInset: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    weak var delegate: TestCategoriesTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: TestCategoriesViewModel?
    
}


// MARK: - TestCategoriesTableViewManagerInput
extension TestCategoriesTableViewManager: TestCategoriesTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        tableView.register(CommonTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.top = Locals.topContentInset
        tableView.backgroundColor = .clear
        self.tableView = tableView
    }
    
    func update(with viewModel: TestCategoriesViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TestCategoriesTableViewManager: UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Locals.defaultRowHeight
    }
    
}


// MARK: - UITableViewDelegate
extension TestCategoriesTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let row = viewModel?.rows[safe: indexPath.row] else {
            return
        }
        
        delegate?.didSelectItem(by: row.categoryId)
    }
}
