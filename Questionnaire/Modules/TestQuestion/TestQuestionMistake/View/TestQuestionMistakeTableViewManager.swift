//
//  TestQuestionMistakeTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestQuestionMistakeTableViewManagerDelegate: AnyObject {  }

protocol TestQuestionMistakeTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: TestQuestionMistakeViewModel)
}

final class TestQuestionMistakeTableViewManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: TestQuestionMistakeTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: TestQuestionMistakeViewModel?
    
}


// MARK: - TestQuestionMistakeTableViewManagerInput
extension TestQuestionMistakeTableViewManager: TestQuestionMistakeTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.register([TestQuestionTitleCell.self,
                            TestQuestionMistakeAnswersCell.self])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        self.tableView = tableView
    }
    
    func update(with viewModel: TestQuestionMistakeViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TestQuestionMistakeTableViewManager: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = viewModel?.rows[safe: indexPath.row] else {
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
extension TestQuestionMistakeTableViewManager: UITableViewDelegate {  }
