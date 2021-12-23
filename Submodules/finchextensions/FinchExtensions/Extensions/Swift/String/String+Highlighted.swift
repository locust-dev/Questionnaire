//
//  String+Highlighted.swift
//  SberSound
//
//  Created by Nick barkovski on 02.11.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

extension String {
    
    // Выделяет найденый тест
    func setHighlighted(with search: String, _ color: UIColor = .white) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        let range = NSString(string: self).range(of: search, options: .caseInsensitive)
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
        
        attributedText.addAttributes(highlightedAttributes, range: range)
        
        return attributedText
    }
    
}
