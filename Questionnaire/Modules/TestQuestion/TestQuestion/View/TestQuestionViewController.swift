//
//  TestQuestionViewController.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

protocol TestQuestionViewInput: Alertable, TabBarPresentable {
    func update(with viewModel: TestQuestionViewModel)
    func setTitle(with questionsCount: Int)
    func showNotConfirmAlert()
    func zoomImage(_ image: UIImage)
    func setListButton(questionsCount: Int?)
}

final class TestQuestionViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: TestQuestionViewOutput?
    var tableViewManager: TestQuestionTableViewManagerInput?
    
    private let tableView = UITableView()
    private let containerView = UIView()
    private let confirmButton = CommonButton(style: .filled)
    private let finishTestButton = CommonButton(style: .filled)
    private let skipQuestionButton = ArrowButton(direction: .right)
    private let returnQuestionButton = ArrowButton(direction: .left)
    private let questionListButton = UIButton()
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if navigationController?.navigationBar.subviews.contains(questionListButton) == true {
            questionListButton.dissapearWithFade(duration: 0.1) { [weak self] in
                self?.questionListButton.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.mainBlueColor()
        navigationItem.hidesBackButton = true
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        
        let bottomButtonsStack = UIStackView(arrangedSubviews: [returnQuestionButton,
                                                                finishTestButton,
                                                                skipQuestionButton])
        bottomButtonsStack.spacing = 10
        bottomButtonsStack.distribution = .equalCentering
        
        questionListButton.setImage(Images.questionList(), for: .normal)
        questionListButton.addTarget(self, action: #selector(openTestListPopover), for: .touchUpInside)
        
        skipQuestionButton.addTarget(self, action: #selector(skipQuestion), for: .touchUpInside)
        returnQuestionButton.addTarget(self, action: #selector(returnQuestion), for: .touchUpInside)
        
        confirmButton.setTitle(Localized.testQuestionAccept(), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTap), for: .touchUpInside)
        
        finishTestButton.setTitle(Localized.testQuestionOver(), for: .normal)
        finishTestButton.addTarget(self, action: #selector(finishTap), for: .touchUpInside)
        
        tableViewManager?.setup(tableView: tableView)
        
        view.addSubview(containerView)
        view.addSubview(bottomButtonsStack)
        containerView.addSubview(tableView)
        containerView.addSubview(confirmButton)
        
        tableView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                      excludingEdge: .bottom)
        
        bottomButtonsStack.autoPinEdge(.top, to: .bottom, of: containerView, withOffset: 10)
        bottomButtonsStack.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20),
                                                        excludingEdge: .top)
        
        skipQuestionButton.autoSetDimensions(to: CGSize(width: 35, height: 50))
        returnQuestionButton.autoSetDimensions(to: CGSize(width: 35, height: 50))
        
        confirmButton.autoPinEdge(.top, to: .bottom, of: tableView, withOffset: 10)
        confirmButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20),
                                                   excludingEdge: .top)
    }
    
    
    // MARK: - Private methods
    
    private func setQuestionListButton(questionsCount: Int?) {
        
        guard let questionsCount = questionsCount,
              let navBar = navigationController?.navigationBar,
              questionsCount > 1
        else {
            return
        }
        
        navBar.addSubview(questionListButton)
        
        questionListButton.autoSetDimensions(to: CGSize(width: 28, height: 28))
        questionListButton.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
        questionListButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
        questionListButton.appearWithFade(duration: 0.4)
    }
    
    private func swipeQuestion(_ direction: Direction, completion: @escaping (Direction) -> Void) {
        
        let leftCornerPosition = view.frame.maxX
        let rightCornerPosition = view.frame.minX - containerView.frame.width
        let firstPosition = direction == .left ? leftCornerPosition : rightCornerPosition
        let secondPosition = direction == .left ? rightCornerPosition : leftCornerPosition
        
        UIView.animate(withDuration: 0.16) {
            self.containerView.frame.origin.x = firstPosition
            
        } completion: { _ in
            self.containerView.frame.origin.x = secondPosition
            completion(direction)
            
            UIView.animate(withDuration: 0.16) {
                self.containerView.center.x = self.view.center.x
            }
        }
    }
    
    private func updateQuestionInfo(with viewModel: TestQuestionViewModel) {
        
        if viewModel.isMistakesShowing {
            
            navigationItem.hidesBackButton = false
            finishTestButton.isHidden = true
            confirmButton.isHidden = true
            tableView.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -20)
        }
        
        returnQuestionButton.isEnabled = viewModel.isReturnButtonEnabled
        skipQuestionButton.isEnabled = viewModel.isSkipButtonEnabled
        tableViewManager?.update(with: viewModel)
        title = "\(Localized.testQuestionWordCount()) \(viewModel.currentQuestionNumber)/\(viewModel.questionsCount)"
    }
    
    
    // MARK: - Actions
    
    @objc private func openTestListPopover() {
        
        guard let rowsCount = tableViewManager?.numberOfQuestions else {
            return
        }
        
        // TODO: - Localize
        let rows = (1...rowsCount).map { TableViewListPopover.Model.Row(title: "Вопрос №\($0)") }
        let model = TableViewListPopover.Model(numberOfRows: rowsCount, rows: rows)
        let popoverVC = TableViewListPopover(viewModel: model)
        let sourceRect = CGRect(x: questionListButton.center.x, y: questionListButton.frame.maxY + 6, width: 0, height: 0)
        
        popoverVC.delegate = self
        popoverVC.preferredContentSize = CGSize(width: 170, height: view.frame.height / 2)
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.sourceView = navigationController?.navigationBar ?? view
        popoverVC.popoverPresentationController?.sourceRect = sourceRect
        popoverVC.popoverPresentationController?.delegate = self
        
        present(popoverVC, animated: true)
    }
    
    @objc private func confirmTap() {
        presenter?.didTapConfirmButton()
    }
    
    @objc private func finishTap() {
        presenter?.didTapFinishButton()
    }
    
    @objc private func skipQuestion() {
        presenter?.didTapSkipQuestion()
    }
    
    @objc private func returnQuestion() {
        presenter?.didTapReturnQuestion()
    }
    
    @objc private func didTapCloseButton() {
        presenter?.didTapCloseButtton()
    }
    
}


// MARK: - TestQuestionViewInput
extension TestQuestionViewController: TestQuestionViewInput {
    
    func setTitle(with questionsCount: Int) {
        title = "\(Localized.testQuestionWordCount()) 1/\(questionsCount)"
    }
    
    func zoomImage(_ image: UIImage) {
        
        let scrollViewWithZoom = ImagePanZoomScrollView(image: image)
        scrollViewWithZoom.alpha = 0
        scrollViewWithZoom.layer.cornerRadius = 12
        
        containerView.addSubview(scrollViewWithZoom)
        scrollViewWithZoom.autoPinEdgesToSuperviewEdges()
        scrollViewWithZoom.appearWithFade()
    }
    
    func update(with viewModel: TestQuestionViewModel) {
        swipeQuestion(viewModel.swipeDirection) { _ in
            self.updateQuestionInfo(with: viewModel)
        }
    }
    
    func showNotConfirmAlert() {
        showAlert(title: Localized.alertChooseAnswerBeforeContinue(), buttonTitle: Localized.buttonOkTitle())
    }
    
    func setListButton(questionsCount: Int?) {
        setQuestionListButton(questionsCount: questionsCount)
    }
}


// MARK: - UIPopoverPresentationControllerDelegate
extension TestQuestionViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
}


// MARK: - TableViewListPopoverDelegate
extension TestQuestionViewController: TableViewListPopoverDelegate {
    
    func didSelectRow(at indexPath: IndexPath) {
        presenter?.didTapMoveToCertainQuestion(indexPath.row + 1)
    }
}
