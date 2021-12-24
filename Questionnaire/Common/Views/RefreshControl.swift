//
//  RefreshControl.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import UIKit
import SwiftUI

protocol RefreshControlModuleInput: AnyObject {
    
    func setupWith(view: UIScrollView, moduleOutput: RefreshControlModuleOutput?)
    func finishedLoading()
}

protocol RefreshControlModuleOutput: AnyObject {
    
    func didRefresh()
}


final class RefreshControl: UIRefreshControl {
    
    // MARK: - Properties
    
    private weak var outputModule: RefreshControlModuleOutput?
    
}


// MARK: - RefreshControlModuleInput
extension RefreshControl: RefreshControlModuleInput {
    
    @objc private func didRefresh() {
        outputModule?.didRefresh()
    }
    
    func setupWith(view: UIScrollView, moduleOutput: RefreshControlModuleOutput?) {
        outputModule = moduleOutput
        view.addSubview(self)
        addTarget(self, action: #selector(RefreshControl.didRefresh), for: .valueChanged)
    }
    
    func finishedLoading() {
        endRefreshing()
    }
    
}
