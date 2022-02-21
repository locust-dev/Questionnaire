//
//  KnowlegdeBasePresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowlegdeBaseViewOutput: ViewOutput, RefreshControlModuleOutput {  }

protocol KnowlegdeBaseInteractorOutput: AnyObject {
    func didSuccessObtainKnowledgeCategories(_ model: [KnowledgeCategoryModel])
    func didFailObtainKnowledgeCategories(_ error: ErrorModel)
}

final class KnowlegdeBasePresenter {
    
    // MARK: - Properties
    
    weak var view: KnowlegdeBaseViewInput?
    
    var router: KnowlegdeBaseRouterInput?
    var interactor: KnowledgeBaseInteractorInput?

    private let dataConverter: KnowlegdeBaseDataConverterInput
    
    
    // MARK: - Init
    
    init(dataConverter: KnowlegdeBaseDataConverterInput) {
        self.dataConverter = dataConverter
    }
    
}


// MARK: - KnowlegdeBaseViewOutput
extension KnowlegdeBasePresenter: KnowlegdeBaseViewOutput {
    
    func viewIsReady() {
        view?.showLoader()
        interactor?.fetchKnowledgeCategories()
    }
    
    func didRefresh() {
        interactor?.fetchKnowledgeCategories()
    }
    
}


// MARK: - KnowlegdeBaseInteractorOutput
extension KnowlegdeBasePresenter: KnowlegdeBaseInteractorOutput {
    
    func didSuccessObtainKnowledgeCategories(_ model: [KnowledgeCategoryModel]) {
        view?.hideLoader()
        let viewModel = dataConverter.convert(categories: model)
        view?.update(with: viewModel)
    }
    
    func didFailObtainKnowledgeCategories(_ error: ErrorModel) {
        view?.hideLoader()
        view?.showErrorPlaceholder(error)
    }

}


// MARK: - KnowlegdeBaseTableViewManagerDelegate
extension KnowlegdeBasePresenter: KnowlegdeBaseTableViewManagerDelegate {  }
