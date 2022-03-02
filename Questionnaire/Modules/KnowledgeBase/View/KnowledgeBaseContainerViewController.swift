//
//  KnowledgeBaseContainerViewController.swift
//  Questionnaire
//
//  Created by Ilya Turin on 02.03.2022.
//

import UIKit

protocol KnowledgeBaseContainerViewControllerDelegate: AnyObject {
    func setHiddenSectionsButton(_ isHidden: Bool)
}

final class KnowledgeBaseContainerViewController: NLViewController {
    
    // MARK: - Properties
    
    private var tabBarHeight: CGFloat {
        tabBarController?.tabBar.frame.height ?? 83
    }
    
    private let childModule: UIViewController
    private let closeAllSectionsButton = UIButton()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    
    // MARK: - Init
    
    init(childModule: UIViewController) {
        self.childModule = childModule
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        navigationController?.largeNavBarTitleAppearance(.white, fontName: MainFont.extraBold, size: 34)
        navigationItem.backButtonTitle = ""
        title = "База знаний"
        
        (childModule as? KnowlegdeBaseViewInput)?.delegate = self
        
        closeAllSectionsButton.setTitle("Свернуть", for: .normal)
        closeAllSectionsButton.titleLabel?.font = UIFont(name: MainFont.bold, size: 14)
        closeAllSectionsButton.setTitleColor(Colors.mainBlueColor(), for: .normal)
        closeAllSectionsButton.backgroundColor = .white
        
        closeAllSectionsButton.layer.shadowColor = UIColor.black.cgColor
        closeAllSectionsButton.layer.shadowOpacity = 0.2
        closeAllSectionsButton.layer.shadowRadius = 3
        closeAllSectionsButton.layer.cornerRadius = 8
        closeAllSectionsButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        closeAllSectionsButton.addTarget(self, action: #selector(closeAllSectionsTap), for: .touchUpInside)
        
        addChild(childModule)
        view.addSubview(childModule.view)
        childModule.view.autoPinEdgesToSuperviewEdges()
        childModule.didMove(toParent: self)
        
        view.addSubview(closeAllSectionsButton)
        
        closeAllSectionsButton.autoSetDimensions(to: CGSize(width: 120, height: 44))
        closeAllSectionsButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        closeAllSectionsButton.autoPinEdge(.top, to: .bottom, of: view, withOffset: tabBarHeight)
    }
    
    
    // MARK: - Private methods
    
    private func setHiddenAnimationSectionsButton(_ isHidden: Bool) {
        
        let viewHeight = view.frame.height
        let closeButtonHeight = closeAllSectionsButton.frame.height
        let hiddenYOrigin = viewHeight - tabBarHeight
        
        UIView.animate(withDuration: 0.2) {
            self.closeAllSectionsButton.frame.origin.y = isHidden ? hiddenYOrigin : hiddenYOrigin - closeButtonHeight
            self.closeAllSectionsButton.layer.shadowOpacity = isHidden ? 0 : 0.2
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func closeAllSectionsTap() {
        (childModule as? KnowlegdeBaseViewInput)?.closeAllSections()
        setHiddenAnimationSectionsButton(true)
    }
    
}


// MARK: - KnowledgeBaseContainerViewControllerDelegate
extension KnowledgeBaseContainerViewController: KnowledgeBaseContainerViewControllerDelegate {
    
    func setHiddenSectionsButton(_ isHidden: Bool) {
        setHiddenAnimationSectionsButton(isHidden)
    }
}
