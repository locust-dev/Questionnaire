//
//  CommonTableView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import UIKit

final class CommonTableView: UITableView {

    // MARK: - Properties

    var loaderColor: UIColor? {
        didSet {
            loaderView.color = loaderColor ?? .blue
        }
    }
    
    var refreshControlColor: UIColor? {
        didSet {
            customRefreshControl.tintColor = refreshControlColor ?? .white
        }
    }
    
    weak var refreshModuleOutput: RefreshControlModuleOutput? {
        didSet {
            customRefreshControl.tintColor = .white
            customRefreshControl.setupWith(view: self, moduleOutput: refreshModuleOutput)
        }
    }
    
    private var isLoading = false {
        didSet {
            setLoader(isLoading)
        }
    }
    
    private let customRefreshControl = RefreshControl()
    private let loaderView = ProgressHUD()
    private let emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.textColor = .white
        emptyLabel.font = MainFont.medium.withSize(18)
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        // TODO: - ...
        emptyLabel.isHidden = true
        emptyLabel.text = "Кажется, мы ничего не нашли\nПопробуйте обновить, потянув вниз"
        return emptyLabel
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Life cycle

    override func reloadData() {
        super.reloadData()
        addEmptyLabel()
    }

    override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        super.reloadSections(sections, with: animation)
        addEmptyLabel()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        loaderColor = .white
        backgroundColor = .clear
    }
    
    
    // MARK: - Public methods
    
    func showLoader() {
        isLoading = true
    }
    
    func hideLoader() {
        isLoading = false
    }
    

    // MARK: - Private methods

    private func addEmptyLabel() {
        
        // TODO: - Подумать над логикой показа лейбла и лоадера в каждой отдельной секции
        
        if numberOfSections == 1, numberOfRows(inSection: 0) == 0, !isLoading {
            addSubview(emptyLabel)
            emptyLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            emptyLabel.autoAlignAxis(.horizontal, toSameAxisOf: superview ?? self)
            emptyLabel.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
            emptyLabel.autoPinEdge(.right, to: .right, of: self, withOffset: 20)

            mainQueue(delay: 0.5) {
                self.emptyLabel.isHidden = false
            }

        } else {
            emptyLabel.removeFromSuperview()
        }
    }
    
    private func setLoader(_ isLoading: Bool) {
        
        guard isLoading else {
            loaderView.removeFromSuperview()
            addEmptyLabel()
            customRefreshControl.finishedLoading()
            return
        }
        
        emptyLabel.removeFromSuperview()
        addSubview(loaderView)
        loaderView.autoAlignAxis(.vertical, toSameAxisOf: superview ?? self)
        loaderView.autoAlignAxis(.horizontal, toSameAxisOf: superview ?? self)
    }

}
