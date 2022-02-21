//
//  KnowledgeCategoryModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 21.02.2022.
//

struct KnowledgeCategoryModel: Decodable {
    
    let title: String
    let topics: [KnowledgeTopic]
}


// MARK: - KnowledgeTopic
struct KnowledgeTopic: Decodable {
    
    let title: String
    let text: String
}
