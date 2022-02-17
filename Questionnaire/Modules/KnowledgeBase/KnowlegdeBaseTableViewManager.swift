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
    
    // MARK: - Properties
    
    weak var delegate: KnowlegdeBaseTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: KnowlegdeBaseViewModel?
    
}


// MARK: - KnowlegdeBaseTableViewManagerInput
extension KnowlegdeBaseTableViewManager: KnowlegdeBaseTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        // Configure your table view here
        //
        //        tableView.delegate = self
        //        tableView.dataSource = self
        
        //...
        
        self.tableView = tableView
    }
    
    func update(with viewModel: KnowlegdeBaseViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension KnowlegdeBaseTableViewManager: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension KnowlegdeBaseTableViewManager: UITableViewDelegate {  }
