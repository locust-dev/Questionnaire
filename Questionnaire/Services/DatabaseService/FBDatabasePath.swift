//
//  FBDatabaseRequestKey.swift
//  Questionnaire
//
//  Created by Ilya Turin on 11.12.2021.
//

enum FBDatabasePath {
   
    case categories
    case rightAnswers(testId: String)
    case test(categoryId: String)
    case allowedTests(token: String)
    case user(token: String)
    
    var stringPath: String {
        
        switch self {
            
        case .categories:
            return "categories"
            
        case .rightAnswers(let testId):
            return "rightAnswers/\(testId)"
            
        case .test(let categoryId):
            return "tests/\(categoryId)"
            
        case .allowedTests(let token):
            return "users/\(token)/allowedTests"
              
        case .user(let token):
            return "users/\(token)"
        }
    }
}
