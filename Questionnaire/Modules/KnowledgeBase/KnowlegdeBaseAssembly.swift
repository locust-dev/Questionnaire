//
//  KnowlegdeBaseAssembly.swift
//  Questionnaire
//
//  Created Ilya Turin on 17.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class KnowlegdeBaseAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Wrong model for KnowledgeBase module")
        }
        
        let tableViewManager = KnowlegdeBaseTableViewManager()
        let dataConverter = KnowlegdeBaseDataConverter()
        
        let view = KnowlegdeBaseViewController()
        let router = KnowlegdeBaseRouter(transition: view)
        let presenter = KnowlegdeBasePresenter(dataConverter: dataConverter)
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.router = router
        
        view.tabBarItem.title = model.tabBarTitle
        view.tabBarItem.image = Images.tabbar_knowledge()
        
        return view
    }

}


// MARK: - Model
extension KnowlegdeBaseAssembly {
    
    struct Model: TransitionModel {
        
        let tabBarTitle: String
    }
    
}
