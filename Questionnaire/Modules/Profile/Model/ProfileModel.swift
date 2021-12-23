//
//  ProfileModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 16.12.2021.
//

struct ProfileModel: Decodable {

    let firstName: String
    let lastName: String
    let uniqueToken: String
    let allowedTests: [String]?
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
