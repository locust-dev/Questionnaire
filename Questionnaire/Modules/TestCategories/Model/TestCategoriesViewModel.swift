//
//  TestCategoriesViewModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

struct TestCategoriesViewModel {
    
    // MARK: - Properties
    
    let rows: [Row]
    
    
    // MARK: - Row
    
    struct Row {
        
        // MARK: - Properties
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var configurator: TableCellConfiguratorProtocol
        
        let categoryId: String
        let category: String
    }
    
}
