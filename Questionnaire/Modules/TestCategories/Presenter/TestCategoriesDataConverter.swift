//
//  TestCategoriesDataConverter.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

protocol TestCategoriesDataConverterInput: AnyObject {
    func convert(categories: [TestCategoryModel]) -> TestCategoriesViewModel
}

final class TestCategoriesDataConverter {
    
    // MARK: - Types
    
    typealias CategoryCellConfigurator = TableCellConfigurator<CommonTableViewCell, CommonTableViewCell.Model>
    
    
    // MARK: - Private methods

    private func createCategoryRow(category: TestCategoryModel) -> TestCategoriesViewModel.Row? {

        guard let title = category.fullTitle, let identifier = category.identifier else {
            return nil
        }
        
        let model = CommonTableViewCell.Model(name: title)
        let configurator = CategoryCellConfigurator(item: model)
        return TestCategoriesViewModel.Row(configurator: configurator, categoryId: identifier)
    }
}


// MARK: - TestCategoriesDataConverterInput
extension TestCategoriesDataConverter: TestCategoriesDataConverterInput {
    
    func convert(categories: [TestCategoryModel]) -> TestCategoriesViewModel {
        let rows = categories.compactMap { createCategoryRow(category: $0) }
        return TestCategoriesViewModel(rows: rows)
    }
    
}
