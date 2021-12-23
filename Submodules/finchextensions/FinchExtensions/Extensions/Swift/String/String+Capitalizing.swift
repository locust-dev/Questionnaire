//
//  String+.swift
//  SberSound
//
//  Created by Николя on 14.09.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

extension String {
    
    // Возвращает строку с первой заглавной буквой
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
}
