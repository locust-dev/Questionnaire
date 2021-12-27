//
//  DatabaseService.swift
//  Questionnaire
//
//  Created by Ilya Turin on 11.12.2021.
//

import Foundation
import FirebaseDatabase

protocol DatabaseServiceInput: AnyObject {
    func getData<Model: Decodable>(_ key: DatabasePath, modelType: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void)
    func saveNewUser(_ newUser: NewUserDatabase, completion: @escaping (Result<String, ErrorModel>) -> Void)
}

final class DatabaseService {
    
    // MARK: - Types
    
    private enum DatabaseReference {
        
        static let realtime = Bundle.main.object(forInfoDictionaryKey: "DatabaseReference")
    }
    
    
    // MARK: - Properties
    
    private let databaseReference = Database.database(url: DatabaseReference.realtime as! String).reference()
    private let networkClient: NetworkClientInput
    
    
    // MARK: - Init
    
    init(networkClient: NetworkClientInput) {
        self.networkClient = networkClient
    }
    
}


// MARK: - FirebaseDatabaseServiceProtocol
extension DatabaseService: DatabaseServiceInput {
    
    func getData<Model: Decodable>(_ key: DatabasePath,
                                   modelType: Model.Type,
                                   completion: @escaping (Result<Model, ErrorModel>) -> Void) {
        
        globalQueue {
            
            self.databaseReference.child(key.stringPath).getData { [weak self] error, data in
                
                guard let dataValue = data.value, error == nil else {
                    
                    mainQueue {
                        
                        completion(.failure(.serverError))
                    }
                    return
                }
                
                self?.networkClient.parse(rawData: dataValue, type: modelType) { model in
                    
                    mainQueue {
                        guard let model = model else {
                            completion(.failure(.parseError))
                            return
                        }
                        
                        completion(.success(model))
                    }
                }
                
                
            }
        }
        
    }
    
    func saveNewUser(_ newUser: NewUserDatabase, completion: @escaping (Result<String, ErrorModel>) -> Void) {
        
        let uniqueToken = newUser.uniqueToken
        let newUserDictionary = newUser.asDictionary
        
        globalQueue {
            let path = DatabasePath.user(token: uniqueToken).stringPath
            self.databaseReference.child(path).setValue(newUserDictionary) { error, _ in
                
                mainQueue {
                    error != nil ? completion(.failure(.errorToSaveNewUser)) : completion(.success(newUser.uniqueToken))
                }
            }
        }
    }
    
}
