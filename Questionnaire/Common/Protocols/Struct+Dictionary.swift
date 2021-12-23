//
//  Struct+Dictionary.swift
//  Questionnaire
//
//  Created by Ilya Turin on 15.12.2021.
//

import Foundation

protocol DictionaryConvertor {
    var asDictionary: NSDictionary { get }
}

extension DictionaryConvertor {
    
    var asDictionary: NSDictionary {
        let reflect = Mirror(reflecting: self)
        let children = reflect.children
        let dictionary = toAnyHashable(elements: children)
        return dictionary
    }
    
    private func toAnyHashable(elements: AnyCollection<Mirror.Child>) -> NSDictionary {
        
        var dictionary: [String : Any] = [:]
        
        for element in elements {
            if let key = element.label {
                
                if let collectionValidHashable = element.value as? [AnyHashable] {
                    dictionary[key] = collectionValidHashable
                }
                
                if let validHashable = element.value as? AnyHashable {
                    dictionary[key] = validHashable
                }
                
                if let convertor = element.value as? DictionaryConvertor {
                    dictionary[key] = convertor.asDictionary
                }
                
                if let convertorList = element.value as? [DictionaryConvertor] {
                    dictionary[key] = convertorList.map({ element in
                        element.asDictionary
                    })
                }
            }
        }
        
        return dictionary as NSDictionary
    }
}
