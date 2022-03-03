//
//  SplashScreenPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 03.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol SplashScreenViewOutput: ViewOutput {  }

protocol SplashScreenInteractorOutput: AnyObject {
    
    func didSuccessToDownloadConfig(_ config: ConfigModel)
    func didFailToDownloadConfig(_ error: ErrorModel)
}


final class SplashScreenPresenter {
    
    // MARK: - Properties
    
    weak var view: SplashScreenViewInput?
    
    var interactor: SplashScreenInteractorInput?
    
}


// MARK: - SplashScreenViewOutput
extension SplashScreenPresenter: SplashScreenViewOutput {
    
    func viewIsReady() {
        interactor?.downloadConfig()
    }
    
}


// MARK: - SplashScreenInteractorOutput
extension SplashScreenPresenter: SplashScreenInteractorOutput {
 
    func didSuccessToDownloadConfig(_ config: ConfigModel) {
        view?.openMainScreen()
    }
    
    func didFailToDownloadConfig(_ error: ErrorModel) {
        view?.showErrorPlaceholder(error)
    }
}
