//
//  TestQuestionViewModel.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import CoreGraphics

struct TestQuestionViewModel {
    
    // MARK: - Types
    
    enum Row {
        
        case title(TableCellConfiguratorProtocol)
        case answerCounter(TableCellConfiguratorProtocol)
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var cellHeight: CGFloat {
            configurator.cellHeight
        }
        
        var configurator: TableCellConfiguratorProtocol {
            switch self {
            case .title(let configurator),
                    .answerCounter(let configurator):
                
                return configurator
            }
        }
    }
    
    
    // MARK: - Properties
    
    let rows: [Row]
    let currentQuestionNumber: Int
    let questionsCount: Int
}
