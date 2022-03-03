//
//  SplashScreenInteractor.swift
//  Questionnaire
//
//  Created by Ilya Turin on 03.03.2022.
//

protocol SplashScreenInteractorInput {
    
    func downloadConfig()
}

final class SplashScreenInteractor {
    
    // MARK: - Properties
    
    weak var presenter: SplashScreenInteractorOutput?
    
    private let configService: ConfigServiceInput
    
    
    // MARK: - Init
    
    init(configService: ConfigServiceInput) {
        self.configService = configService
    }
    
}


// MARK: - SplashScreenInteractorInput
extension SplashScreenInteractor: SplashScreenInteractorInput {

    func downloadConfig() {
        
        configService.fetchConfig { result in
            
            mainQueue {
                
                switch result {
                    
                case .success(let configModel):
                    self.presenter?.didSuccessToDownloadConfig(configModel)
                    
                case .failure(let error):
                    self.presenter?.didFailToDownloadConfig(error)
                }
            }
        }
    }

}
