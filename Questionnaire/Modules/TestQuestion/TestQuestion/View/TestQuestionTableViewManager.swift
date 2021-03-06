//
//  TestQuestionTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestQuestionTableViewManagerDelegate: CodeSampleCellDelegate {
    func didSelectAnswers(_ answers: [Int])
}

protocol TestQuestionTableViewManagerInput {
    
    var numberOfQuestions: Int? { get }
    
    func setup(tableView: UITableView)
    func update(with viewModel: TestQuestionViewModel)
}

final class TestQuestionTableViewManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: TestQuestionTableViewManagerDelegate?
    
    var numberOfQuestions: Int? {
        viewModel?.questionsCount
    }
    
    private weak var tableView: UITableView?
    
    private var viewModel: TestQuestionViewModel?
    
}


// MARK: - TestQuestionTableViewManagerInput
extension TestQuestionTableViewManager: TestQuestionTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.register([TestQuestionTitleCell.self,
                            TestAnswersCounterCell.self,
                            CodeSampleCell.self,
                            TestQuestionExplanationCell.self])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        self.tableView = tableView
    }
    
    func update(with viewModel: TestQuestionViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension TestQuestionTableViewManager: UITableViewDataSource {
   
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.rows[safe: indexPath.row]?.configurator.cellHeight ?? 0
    }
    
}


// MARK: - UITableViewDelegate
extension TestQuestionTableViewManager: UITableViewDelegate { }
