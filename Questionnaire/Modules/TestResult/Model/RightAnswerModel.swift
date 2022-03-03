//
//  RightAnswerModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 03.03.2022.
//

struct RightAnswerModel: Decodable {
    
    let answers: [Int]
    let explanation: String?
}
