//
//  NetworkClient.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import Foundation

protocol NetworkClientInput {
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void)
}

final class NetworkClient { }


// MARK: - NetworkClientInput
extension NetworkClient: NetworkClientInput {
    
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void) {
        
        globalQueue {
            
            guard (rawData as? NSNull) == nil else {
                completion(.failure(.parseError))
                return
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: rawData)
                let decodedData = try JSONDecoder().decode(Model.self, from: json)
                completion(.success(decodedData))
                
            } catch(let error) {
                print(error.localizedDescription)
                completion(.failure(.parseError))
            }
        }
    }
    
}
