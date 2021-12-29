//
//  QuestionMistakeModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

struct QuestionMistakeModel {
    
    let questionNumber: Int
    let wrongAnswers: [Int]
    let selectedRightAnswers: [Int]
    let missingRightAnswers: [Int]
}
