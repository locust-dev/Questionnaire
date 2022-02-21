//
//  KnowlegdeBaseDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import CoreGraphics

protocol KnowlegdeBaseDataConverterInput {
    func convert(categories: [KnowledgeCategoryModel]) -> KnowlegdeBaseViewModel
}

final class KnowlegdeBaseDataConverter {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let cellHeight: CGFloat = 50
        static let headerHeight: CGFloat = 50
    }
    
    
    // MARK: - Typealiases
    
    typealias Section = KnowlegdeBaseViewModel.Section
    typealias Row = KnowlegdeBaseViewModel.Row
    
    typealias HeaderConfigurator = TableHeaderFooterConfigurator<KnowlegdeHeaderCell, KnowlegdeHeaderCell.Model>
    typealias RowConfigurator = TableCellConfigurator<KnowledgeCell, KnowledgeCell.Model>
    
    
    // MARK: - Private methods
    
    private func createCategorySection(_ model: KnowledgeCategoryModel, sectionIndex: Int) -> Section {
        
        let rows = createTopicRows(model.topics)
        let headerModel = KnowlegdeHeaderCell.Model(title: model.title, sectionIndex: sectionIndex)
        let headerConfigurator = HeaderConfigurator(item: headerModel, viewHeight: Locals.headerHeight)
        
        return Section(headerConfigurator: headerConfigurator, rows: rows)
    }
    
    private func createTopicRows(_ model: [KnowledgeTopic]) -> [Row] {
        
        return model.map { topic -> Row in
            
            let model = KnowledgeCell.Model(title: topic.title)
            let configurator = RowConfigurator(item: model, cellHeight: Locals.cellHeight)
            return Row(configurator: configurator)
        }
    }
        
}


// MARK: - KnowlegdeBaseDataConverterInput
extension KnowlegdeBaseDataConverter: KnowlegdeBaseDataConverterInput {
    
    func convert(categories: [KnowledgeCategoryModel]) -> KnowlegdeBaseViewModel {
        
        let sections = categories.enumerated().map { createCategorySection($1, sectionIndex: $0) }
        return KnowlegdeBaseViewModel(sections: sections)
    }
    
}
