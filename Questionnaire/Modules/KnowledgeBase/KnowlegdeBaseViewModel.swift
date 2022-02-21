//
//  KnowlegdeBaseViewModel.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import SwiftUI

struct KnowlegdeBaseViewModel {
    
    // MARK: - Types
    
    struct Section {
        
        // MARK: - Properties
        
        let headerConfigurator: TableHeaderFooterConfiguratorProtocol?
        let rows: [Row]
    }
    
    struct Row {
        
        // MARK: - Properties
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var configurator: TableCellConfiguratorProtocol
    }
    
    
    // MARK: - Properties
    
    let sections: [Section]
    
}
