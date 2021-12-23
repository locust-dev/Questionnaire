//
//  ProfileDataConverter.swift
//  Questionnaire
//
//  Created by Ilya Turin on 16.12.2021.
//

import CoreGraphics

protocol ProfileDataConverterInput {
    func convert(profileModel: ProfileModel) -> ProfileViewModel
}

final class ProfileDataConverter {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let defaultRowHeight: CGFloat = 60
    }
    
    
    // MARK: - Types
    
    typealias ProfileCellConfigurator = TableCellConfigurator<ProfileListCell, ProfileListCell.Model>
    
    
    // MARK: - Private methods
    
    private func createProfileListRow(title: String) -> ProfileViewModel.Row {
        let model = ProfileListCell.Model(title: title)
        let configurator = ProfileCellConfigurator(item: model, cellHeight: Locals.defaultRowHeight)
        return ProfileViewModel.Row(configurator: configurator)
    }
    
}


// MARK: - ProfileDataConverterInput
extension ProfileDataConverter: ProfileDataConverterInput {
    
    func convert(profileModel: ProfileModel) -> ProfileViewModel {
        
        // TODO: - Следующая итерация
        let titles = [
            "Пройденные тесты",
            "Статистика",
            "Настройки"
        ]
        
        let rows = titles.map { createProfileListRow(title: $0) }
        
        return ProfileViewModel(firstName: profileModel.lastName,lastName: profileModel.firstName, rows: rows)
    }
}
