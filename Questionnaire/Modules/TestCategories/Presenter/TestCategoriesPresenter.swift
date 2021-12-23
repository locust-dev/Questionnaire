//
//  TestCategoriesPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 10.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestCategoriesViewOutput: ViewOutput, RefreshControlModuleOutput { }

protocol TestCategoriesInteractorOutput: AnyObject {
    func didSuccessObtain(categories: [TestCategoryModel])
    func didFailObtainCategories(error: ErrorModel)
}

final class TestCategoriesPresenter {
    
    // MARK: - Properties
    
    weak var view: TestCategoriesViewInput?
    
    var router: TestCategoriesRouterInput?
    var interactor: TestCategoriesInteractorInput?
    
    private let dataConverter: TestCategoriesDataConverterInput
    
    
    // MARK: - Init
    
    init(dataConverter: TestCategoriesDataConverterInput) {
        self.dataConverter = dataConverter
    }
    
}


// MARK: - TestListViewOutput
extension TestCategoriesPresenter: TestCategoriesViewOutput {
    
    func viewIsReady() {
        view?.showLoader()
        interactor?.getCategories()
    }
    
    func didRefresh() {
        view?.showLoader()
        interactor?.getCategories()
    }
    
}


// MARK: - TestCategoriesInteractorOutput
extension TestCategoriesPresenter: TestCategoriesInteractorOutput {
    
    func didSuccessObtain(categories: [TestCategoryModel]) {
        view?.hideLoader()
        let viewModel = dataConverter.convert(categories: categories)
        view?.update(with: viewModel)
    }
    
    func didFailObtainCategories(error: ErrorModel) {
        view?.hideLoader()
        view?.showErrorPlaceholder(error)
    }
    
}


// MARK: - TestCategoriesTableViewManagerDelegate
extension TestCategoriesPresenter: TestCategoriesTableViewManagerDelegate {
    
    func didSelectItem(by categoryId: String) {
        
        guard interactor?.isAuthorized == true else {
            view?.showNonAuthorizedAlert()
            return
        }
        
        router?.openTests(by: categoryId)
    }
    
}
