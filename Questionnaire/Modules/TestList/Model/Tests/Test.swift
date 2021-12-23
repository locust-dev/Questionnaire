//
//  Test.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

struct Test: Decodable {
    
    let testId: String?
    let testName: String?
    let questions: [Question]?
}
