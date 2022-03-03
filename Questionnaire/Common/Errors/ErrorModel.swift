//
//  ErrorModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import Foundation

enum ErrorModel: Error {
    
    // Entire
    case somethingWentWrong
    case serverError
    case nonShowingError
  
    // Users
    case userNotFound
    case userNotAuthorized
    case userNotFoundInDatabase
    case errorToRegisterNewUser
    case errorToSaveNewUser
    case errorToLoadUserInfo
    
    // Answers
    case notFindAnswers
    
    // JSON
    case parseError
    
    var description: String {
        
        switch self {
            
        case .nonShowingError:
            return ""
            
        case .somethingWentWrong:
            return Localized.errorSomethingWentWrong()
            
        case .serverError:
            return Localized.errorServerError()
            
        case .userNotAuthorized:
            return Localized.errorUserNotAuthorized()
            
        case .userNotFoundInDatabase:
            return Localized.errorUserNotFoundInDatabase()
            
        case .errorToRegisterNewUser:
            return Localized.errorToRegisterNewUser()
            
        case .errorToSaveNewUser:
            return Localized.errorToSaveNewUser()
            
        case .errorToLoadUserInfo:
            return Localized.errorToLoadUserInfo()
            
        case .notFindAnswers:
            return Localized.errorNotFindAnswers()
            
        case .userNotFound:
            return Localized.errorUserNotFound()
            
        case .parseError:
            return Localized.errorParseError()
        }
    }
}
