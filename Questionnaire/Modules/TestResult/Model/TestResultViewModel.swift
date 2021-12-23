//
//  TestResultViewModel.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import CoreGraphics

struct TestResultViewModel {
    
    // MARK: - Types
    
    enum Row {
        
        case circleProgress(TableCellConfiguratorProtocol)
        case mistakes(TableCellConfiguratorProtocol)
        case finishButton(TableCellConfiguratorProtocol)
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var cellHeight: CGFloat {
            configurator.cellHeight
        }
        
        var configurator: TableCellConfiguratorProtocol {
            switch self {
            case .circleProgress(let configurator),
                 .mistakes(let configurator),
                 .finishButton(let configurator):
                return configurator
            }
        }
    }
    
    
    // MARK: - Properties
    
    let rows: [Row]
    let finishButtonTitle: String
}
