//
//  TestResultTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestResultTableViewManagerDelegate: AnyObject {
    func didSelectQuestionWithMistake(by number: Int)
}

protocol TestResultTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TestResultViewModel)
}

final class TestResultTableViewManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: TestResultTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: TestResultViewModel?
    
}


// MARK: - TestResultTableViewManagerInput
extension TestResultTableViewManager: TestResultTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.register([TestResultMistakesCell.self, TestResultCircleProgressCell.self])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        self.tableView = tableView
    }
    
    func update(with viewModel: TestResultViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TestResultTableViewManager: UITableViewDataSource {
   
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
        
        (cell as? Delegatable)?.delegate = delegate
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension TestResultTableViewManager: UITableViewDelegate {  }
