//
//  KnowlegdeBaseTableViewManager.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol KnowlegdeBaseTableViewManagerDelegate: AnyObject {
    func didSelectTopic(_ topic: KnowledgeTopic)
    func didExpandAtLeastOneSection(_ isExpanded: Bool)
}

protocol KnowlegdeBaseTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: KnowlegdeBaseViewModel)
    func didTapCloseAllSections()
}

final class KnowlegdeBaseTableViewManager: NSObject {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let topContentInset: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    weak var delegate: KnowlegdeBaseTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: KnowlegdeBaseViewModel?
    private var expandedSections = Set<Int>()
    
    
    // MARK: - Private methods
    
    private func rowsIndexForSection(at index: Int) -> [IndexPath]? {
        viewModel?.sections[safe: index]?.rows.enumerated().map({ rowIndex, _ in
            IndexPath(row: rowIndex, section: index)
        })
    }
    
    private func rowsIndexForAllExpandedSections() -> [IndexPath] {
        var indexes: [IndexPath]? = []
        expandedSections.forEach { indexes! += rowsIndexForSection(at: $0) ?? [] }
        return indexes ?? []
    }
    
}


// MARK: - KnowlegdeBaseTableViewManagerInput
extension KnowlegdeBaseTableViewManager: KnowlegdeBaseTableViewManagerInput {
    
    func didTapCloseAllSections() {
        let sectionsIndexes = rowsIndexForAllExpandedSections()
        expandedSections.removeAll()
        tableView?.deleteRows(at: sectionsIndexes, with: .top)
    }
    
    func setup(tableView: UITableView) {
       
        tableView.register(KnowlegdeHeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: KnowlegdeHeaderCell.className)
        
        tableView.register(KnowledgeCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.top = Locals.topContentInset
        tableView.contentInset.bottom = Locals.topContentInset
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
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
        expandedSections.contains(section) ? viewModel?.sections[section].rows.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = viewModel,
              let section = viewModel.sections[safe: indexPath.section],
              let row = section.rows[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
        cell.selectionStyle = .none
        
        row.configurator.configure(cell: cell)
        
        if row.isBottomCurved {
            (cell as? KnowledgeCell)?.makeBottomCurved()
        }
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension KnowlegdeBaseTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let section = viewModel?.sections[safe: indexPath.section],
              let row = section.rows[safe: indexPath.row]
        else {
            return
        }
        
        delegate?.didSelectTopic(row.topic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.sections[safe: indexPath.section]?.rows[safe: indexPath.row]?.configurator.cellHeight ?? 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        guard let currentSection = viewModel?.sections[safe: section],
              let configurator = currentSection.headerConfigurator,
              let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: configurator).reuseId)
        else {
            return nil
        }
        
        configurator.configure(cell: view)
        
        if let cell = view as? KnowlegdeHeaderCell {
            cell.delegate = self
            cell.isExpanded = expandedSections.contains(section)
            
            if currentSection.isBottomCurved {
                cell.makeBottomCurved()
            } else if currentSection.isTopCurved {
                cell.makeTopCurved()
            }
        }
        
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


// MARK: - KnowledgeHeaderCellDelegate
extension KnowlegdeBaseTableViewManager: KnowledgeHeaderCellDelegate {
    
    func didTapHeaderCell(at index: Int) {
        
        guard let rowsIndexes = rowsIndexForSection(at: index) else {
            return
        }
        
        if expandedSections.contains(index) {
            expandedSections.remove(index)
            tableView?.deleteRows(at: rowsIndexes, with: .top)
            
        } else {
            expandedSections.insert(index)
            tableView?.insertRows(at: rowsIndexes, with: .top)
        }
        
        delegate?.didExpandAtLeastOneSection(!expandedSections.isEmpty)
    }

}
