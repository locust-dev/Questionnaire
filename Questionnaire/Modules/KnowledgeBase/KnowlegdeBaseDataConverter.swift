//
//  KnowlegdeBaseDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol KnowlegdeBaseDataConverterInput {
    func convert() -> KnowlegdeBaseViewModel?
}

final class KnowlegdeBaseDataConverter {  }


// MARK: - KnowlegdeBaseDataConverterInput
extension KnowlegdeBaseDataConverter: KnowlegdeBaseDataConverterInput {
    
    func convert() -> KnowlegdeBaseViewModel? {
        return nil
    }
    
}
