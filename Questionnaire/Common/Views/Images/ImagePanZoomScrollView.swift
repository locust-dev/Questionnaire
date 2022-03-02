//
//  ImagePanZoomScrollView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 02.03.2022.
//

import UIKit

final class ImagePanZoomScrollView: UIScrollView {
    
    // MARK: - Properties

    private let imageView = UIImageView()

    
    // MARK: - Init

    init(image: UIImage) {
        super.init(frame: .zero)
        self.imageView.image = image
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    
    // MARK: - Drawing

    private func drawSelf() {
        
        backgroundColor = .white.withAlphaComponent(0.9)
        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oneTap)))
        
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        
        imageView.autoMatch(.height, to: .height, of: self)
        imageView.autoMatch(.width, to: .width, of: self)
        imageView.autoCenterInSuperview()
    }
    
    
    // MARK: - Actions

    @objc private func oneTap() {
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
}


// MARK: - UIScrollViewDelegate
extension ImagePanZoomScrollView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
       imageView
    }
}
