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
        
        static let cellHeight: CGFloat = 60
        static let headerHeight: CGFloat = 70
    }
    
    
    // MARK: - Typealiases
    
    typealias Section = KnowlegdeBaseViewModel.Section
    typealias Row = KnowlegdeBaseViewModel.Row
    
    typealias HeaderConfigurator = TableHeaderFooterConfigurator<KnowlegdeHeaderCell, KnowlegdeHeaderCell.Model>
    typealias RowConfigurator = TableCellConfigurator<KnowledgeCell, KnowledgeCell.Model>
    
    
    // MARK: - Private methods
    
    private func createCategorySection(_ model: KnowledgeCategoryModel,
                                       sectionIndex: Int,
                                       numberOfSections: Int) -> Section {
        
        let isTopCurved = sectionIndex == 0
        let isBottomCurved = sectionIndex == numberOfSections - 1
        
        let rows = createTopicRows(model.topics, isLastSection: isBottomCurved)
        let headerModel = KnowlegdeHeaderCell.Model(title: model.title,
                                                    sectionIndex: sectionIndex,
                                                    numberOfSections: numberOfSections)
        
        let headerConfigurator = HeaderConfigurator(item: headerModel, viewHeight: Locals.headerHeight)
        
        return Section(isTopCurved: isTopCurved,
                       isBottomCurved: isBottomCurved,
                       headerConfigurator: headerConfigurator,
                       rows: rows)
    }
    
    private func createTopicRows(_ model: [KnowledgeTopic], isLastSection: Bool) -> [Row] {
        
        return model.enumerated().map { (rowIndex, topic) -> Row in
            
            let isBottomCurved = rowIndex == model.count - 1 && isLastSection
            let cellModel = KnowledgeCell.Model(title: topic.title)
            let configurator = RowConfigurator(item: cellModel, cellHeight: Locals.cellHeight)
            return Row(configurator: configurator, topic: topic, isBottomCurved: isBottomCurved)
        }
    }
        
}


// MARK: - KnowlegdeBaseDataConverterInput
extension KnowlegdeBaseDataConverter: KnowlegdeBaseDataConverterInput {
    
    func convert(categories: [KnowledgeCategoryModel]) -> KnowlegdeBaseViewModel {
        
        let sections = categories.enumerated().map {
            createCategorySection($1, sectionIndex: $0, numberOfSections: categories.count)
        }
        
        return KnowlegdeBaseViewModel(sections: sections)
    }
    
}
