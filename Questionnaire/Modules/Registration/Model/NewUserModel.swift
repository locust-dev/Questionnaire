//
//  NewUserModel.swift
//  Questionnaire
//
//  Created Ilya Turin on 15.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

struct NewUserModel: DictionaryConvertor {
    
    let uniqueToken: String
    let firstName: String
    let lastName: String
}
