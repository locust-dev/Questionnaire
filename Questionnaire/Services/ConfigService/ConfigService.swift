//
//  ConfigService.swift
//  Questionnaire
//
//  Created by Ilya Turin on 03.03.2022.
//

protocol ConfigServiceInput {
    
    func fetchConfig(completion: @escaping (Result<ConfigModel, ErrorModel>) -> Void)
}

final class ConfigService {

    // MARK: - Properties
    
    private let databaseService: DatabaseServiceInput
    
    
    // MARK: - Init
    
    init(databaseService: DatabaseServiceInput) {
        self.databaseService = databaseService
    }
}


// MARK: - ConfigServiceInput
extension ConfigService: ConfigServiceInput {
    
    func fetchConfig(completion: @escaping (Result<ConfigModel, ErrorModel>) -> Void) {
        
        databaseService.getData(.config, modelType: ConfigModel.self) { result in
            
            switch result {
                
            case .success(let config):
                completion(.success(config))
                
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
}
