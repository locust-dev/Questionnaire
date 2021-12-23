//
//  TestsModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

struct TestsModel: Decodable {
    
    let categoryIdentifier: String
    let each: [Test]
}
