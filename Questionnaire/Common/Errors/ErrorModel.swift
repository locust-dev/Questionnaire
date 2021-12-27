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
            
        // TODO: - Localized
        case .nonShowingError:
            return ""
            
        case .somethingWentWrong:
            return "Что то пошло не так."
            
        case .serverError:
            return "Ошибка сервера. Попробуйте позже."
            
        case .userNotAuthorized:
            return "Не можем авторизовать"
            
        case .userNotFoundInDatabase:
            return "Мы не нашли вас в базе.\nСоздали аккаунт пол умолчанию"
            
        case .errorToRegisterNewUser:
            return "Не смогли зарегестрировать нового пользователя"
            
        case .errorToSaveNewUser:
            return "Не смогли сохранить пользователя в базе"
            
        case .errorToLoadUserInfo:
            return "Не можем загрузить информацию о профиле"
            
        case .notFindAnswers:
            return "Хм. Не смогли найти правильные ответы на этот тест!"
            
        case .userNotFound:
            return "Пользователь не найден."
            
        case .parseError:
            return "Ошибка парсинга JSON"
        }
    }
}
