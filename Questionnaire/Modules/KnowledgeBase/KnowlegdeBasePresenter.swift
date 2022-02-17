//
//  KnowlegdeBasePresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowlegdeBaseViewOutput: ViewOutput, RefreshControlModuleOutput {  }

protocol KnowlegdeBaseInteractorOutput: AnyObject {  }

final class KnowlegdeBasePresenter {
    
    // MARK: - Properties
    
    weak var view: KnowlegdeBaseViewInput?
    
    var router: KnowlegdeBaseRouterInput?

    private let dataConverter: KnowlegdeBaseDataConverterInput
    
    
    // MARK: - Init
    
    init(dataConverter: KnowlegdeBaseDataConverterInput) {
        self.dataConverter = dataConverter
    }
    
}


// MARK: - KnowlegdeBaseViewOutput
extension KnowlegdeBasePresenter: KnowlegdeBaseViewOutput {
    
    func viewIsReady() {  }
    
    func didRefresh() {
        view?.hideLoader()
    }
    
}


// MARK: - KnowlegdeBaseInteractorOutput
extension KnowlegdeBasePresenter: KnowlegdeBaseInteractorOutput {  }


// MARK: - KnowlegdeBaseTableViewManagerDelegate
extension KnowlegdeBasePresenter: KnowlegdeBaseTableViewManagerDelegate {  }
