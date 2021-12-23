//
//  Question.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

struct Question: Decodable {
    
    let text: String
    let answers: [String]
}
