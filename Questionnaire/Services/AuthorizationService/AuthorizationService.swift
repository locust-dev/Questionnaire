//
//  AuthorizationService.swift
//  Questionnaire
//
//  Created by Ilya Turin on 10.12.2021.
//

import FirebaseAuth

protocol AuthorizationServiceInput {
    
    var isAuthorized: Bool { get }
    var currentUserToken: String? { get }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void)
    func registerUser(with email: String, and password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void)
    func setCurrentUserToken(_ token: String?)
    func logOut()
}

final class AuthorizationService {
    
    // MARK: - Types
    
    private enum UserDefaultsKey {
        
        static let userId = "userId"
    }
    
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
}


// MARK: - FirebaseAuthServiceProtocol
extension AuthorizationService: AuthorizationServiceInput {
    
    var isAuthorized: Bool {
        userDefaults.value(forKey: UserDefaultsKey.userId) != nil
    }
    
    var currentUserToken: String? {
        userDefaults.value(forKey: UserDefaultsKey.userId) as? String
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void) {
        
        globalQueue {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                mainQueue { 
                    error != nil ? completion(.failure(.userNotFound)) : completion(.success(result?.user.uid))
                }
            }
        }
    }
    
    func registerUser(with email: String, and password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void) {
        
        globalQueue {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                mainQueue {
                    error != nil ? completion(.failure(.errorToRegisterNewUser)) : completion(.success(result?.user.uid))
                }
            }
        }
    }
    
    func setCurrentUserToken(_ token: String?) {
        userDefaults.set(token, forKey: UserDefaultsKey.userId)
    }
    
    func logOut() {
        setCurrentUserToken(nil)
    }
}
