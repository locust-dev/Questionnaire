//
//  TableViewListPopover.swift
//  Questionnaire
//
//  Created by Ilya Turin on 04.03.2022.
//

import UIKit

protocol TableViewListPopoverDelegate: AnyObject {
    func didSelectRow(at indexPath: IndexPath)
}

final class TableViewListPopover: UITableViewController {
    
    // MARK: - Types

    struct Model {
        
        let numberOfRows: Int
        let rows: [Row]
        
        struct Row {
            
            let title: String
        }
    }
    
    
    // MARK: - Properties
    
    weak var delegate: TableViewListPopoverDelegate?
    
    private let viewModel: Model
    
    
    // MARK: - Init
    
    init(viewModel: Model) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        
        tableView.register(TableViewPopoverCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
}

// MARK: - UITableViewDataSource
extension TableViewListPopover {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewPopoverCell.className, for: indexPath) as? TableViewPopoverCell else {
            return UITableViewCell()
        }
        
        let model = TableViewPopoverCell.Model(title: viewModel.rows[indexPath.row].title)
        cell.configure(with: model)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension TableViewListPopover {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
    }
}
