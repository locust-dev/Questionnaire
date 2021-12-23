//
//  ProfileViewModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 10.12.2021.
//

struct ProfileViewModel {
    
    // MARK: - Properties
    
    let firstName: String
    let lastName: String
    let rows: [Row]
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    
    // MARK: - Row
    
    struct Row {
        
        // MARK: - Properties
        
        var identifier: String {
            type(of: configurator).reuseId
        }
        
        var configurator: TableCellConfiguratorProtocol
    }

}
