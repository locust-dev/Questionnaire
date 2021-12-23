//
//  TestListViewModel.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

struct TestListViewModel {
    
    // MARK: - Properties
    
    let rows: [Row]
    let tests: [Test]
    
    
    // MARK: - Row
    
    struct Row {
        
        // MARK: - Properties
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var configurator: TableCellConfiguratorProtocol
    }
    
}
