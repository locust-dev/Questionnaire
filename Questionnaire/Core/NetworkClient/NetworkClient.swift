//
//  NetworkClient.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import Foundation

protocol NetworkClientInput {
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Model?) -> Void)
}

final class NetworkClient { }


// MARK: - NetworkClientInput
extension NetworkClient: NetworkClientInput {
    
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Model?) -> Void) {
        
        globalQueue {
            
            guard (rawData as? NSNull) == nil else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: rawData)
                let decodedData = try JSONDecoder().decode(Model.self, from: json)
                completion(decodedData)
                
            } catch(let error) {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
