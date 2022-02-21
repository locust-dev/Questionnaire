//
//  KnowlegdeBaseTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol KnowlegdeBaseTableViewManagerDelegate: AnyObject {  }

protocol KnowlegdeBaseTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: KnowlegdeBaseViewModel)
}

final class KnowlegdeBaseTableViewManager: NSObject {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let defaultRowHeight: CGFloat = 90
        static let topContentInset: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    weak var delegate: KnowlegdeBaseTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: KnowlegdeBaseViewModel?
    
}


// MARK: - KnowlegdeBaseTableViewManagerInput
extension KnowlegdeBaseTableViewManager: KnowlegdeBaseTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.register(KnowlegdeHeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: KnowlegdeHeaderCell.className)
        
        tableView.register(KnowledgeCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.top = Locals.topContentInset
        self.tableView = tableView
    }
    
    func update(with viewModel: KnowlegdeBaseViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension KnowlegdeBaseTableViewManager: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[safe: section]?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = viewModel?.sections[safe: indexPath.section],
              let row = section.rows[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        row.configurator.configure(cell: cell)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension KnowlegdeBaseTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.sections[safe: indexPath.section]?.rows[safe: indexPath.row]?.configurator.cellHeight ?? 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        guard let section = viewModel?.sections[safe: section],
              let configurator = section.headerConfigurator,
              let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: configurator).reuseId)
        else {
            return nil
        }
        
        configurator.configure(cell: view)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        guard let section = viewModel?.sections[safe: section],
              let configurator = section.headerConfigurator
        else {
            return 0
        }
                
        return configurator.viewHeight
    }
}
