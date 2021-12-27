//
//  NewUserDatabase.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

struct NewUserDatabase: Encodable {
    
    let uniqueToken: String
    let firstName: String
    let lastName: String
    let allowedTests: [String]
}
