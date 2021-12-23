//
//  FBAuthService.swift
//  Questionnaire
//
//  Created by Ilya Turin on 10.12.2021.
//

import FirebaseAuth

protocol FBAuthServiceInput {
    
    var isAuthorized: Bool { get }
    var currentUserToken: String? { get }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void)
    func setCurrentUserToken(_ token: String?)
    func logOut()
}

final class FBAuthService {
    
    // MARK: - Types
    
    private enum UserDefaultsKey: String {
        
        case userId
    }
    
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
}


// MARK: - FirebaseAuthServiceProtocol
extension FBAuthService: FBAuthServiceInput {
    
    var isAuthorized: Bool {
        userDefaults.value(forKey: UserDefaultsKey.userId.rawValue) != nil
    }
    
    var currentUserToken: String? {
        userDefaults.value(forKey: UserDefaultsKey.userId.rawValue) as? String
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String?, ErrorModel>) -> Void) {
        
        globalQueue {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                mainQueue {
                    error != nil
                        ? completion(.failure(.userNotFound))
                        : completion(.success(result?.user.uid))
                }
            }
        }
    }
    
    func setCurrentUserToken(_ token: String?) {
        userDefaults.set(token, forKey: UserDefaultsKey.userId.rawValue)
    }
    
    func logOut() {
        setCurrentUserToken(nil)
    }
}
