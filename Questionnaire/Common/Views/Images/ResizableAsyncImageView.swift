//
//  ResizableAsyncImageView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 01.03.2022.
//

import UIKit

/// Класс берет доступную ширину Image view и увеличивает высоту пропорционально в момент установки изображения

final class ResizableAsyncImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            
            guard let image = image else {
                return
            }
            
            let aspect = image.size.width / image.size.height
            autoSetDimension(.height, toSize: frame.width / aspect)
        }
    }
    
}
