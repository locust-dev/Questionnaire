//
//  FBDatabaseService.swift
//  Questionnaire
//
//  Created by Ilya Turin on 11.12.2021.
//

import Foundation
import FirebaseDatabase

protocol FBDatabaseServiceInput: AnyObject {
    func getData<Model: Decodable>(_ key: FBDatabasePath, model: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void)
    func saveNewUser(_ newUser: NewUserModel, completion: @escaping (Result<String, ErrorModel>) -> Void)
}

final class FBDatabaseService {
    
    // MARK: - Properties
    
    private let databaseReference = Database.database(url: FBDatabaseReference.realtime.rawValue).reference()
    private let networkClient: NetworkClientInput
    
    
    // MARK: - Init
    
    init(networkClient: NetworkClientInput) {
        self.networkClient = networkClient
    }
    
}


// MARK: - FirebaseDatabaseServiceProtocol
extension FBDatabaseService: FBDatabaseServiceInput {
    
    func getData<Model: Decodable>(_ key: FBDatabasePath,
                                   model: Model.Type,
                                   completion: @escaping (Result<Model, ErrorModel>) -> Void) {
        
        globalQueue {
            
            self.databaseReference.child(key.stringPath).getData { [weak self] error, data in
                guard let dataValue = data.value, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                self?.networkClient.parse(rawData: dataValue, type: model) { model in
                    
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
    
    func saveNewUser(_ newUser: NewUserModel, completion: @escaping (Result<String, ErrorModel>) -> Void) {
        
        globalQueue {
            let path = FBDatabasePath.user(token: newUser.uniqueToken).stringPath
            self.databaseReference.child(path).setValue(newUser.asDictionary) { error, _ in
                
                mainQueue {
                    error != nil
                    ? completion(.failure(.errorToSaveNewUser))
                    : completion(.success(newUser.uniqueToken))
                }
            }
        }
    }
    
}
