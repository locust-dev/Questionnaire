//
//  TestResultPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestResultViewOutput: ViewOutput {
    func didTapFinishButton()
    func didTapOkErrorButton()
}

protocol TestResultInteractorOutput: AnyObject {
    func didSuccessObtainAnswers(_ answers: [[Int]])
    func didFailObtainAnswers(error: ErrorModel)
}

final class TestResultPresenter {
    
    // MARK: - Properties
    
    weak var view: TestResultViewInput?
    
    var router: TestResultRouterInput?
    var interactor: TestResultInteractorInput?
    
    private var rightAnswers: [[Int]]?
    private var mistakes: [QuestionMistakeModel]?

    private let dataConverter: TestResultDataConverterInput
    private let userAnswers: [UserAnswerModel]
    private let testId: String
    private let questions: [Question]
    
    
    // MARK: - Init
    
    init(questions: [Question],
         dataConverter: TestResultDataConverterInput,
         userAnswers: [UserAnswerModel],
         testId: String) {
        
        self.questions = questions
        self.dataConverter = dataConverter
        self.userAnswers = userAnswers
        self.testId = testId
    }
    
}


// MARK: - TestResultViewOutput
extension TestResultPresenter: TestResultViewOutput {
    
    func didTapFinishButton() {
        router?.closeModule()
        view?.showTabBar()
    }
    
    func didTapOkErrorButton() {
        router?.closeModule()
    }
    
    func viewIsReady() {
        view?.showHUD()
        interactor?.getRightAnswers(by: testId)
    }
    
}


// MARK: - TestResultInteractorOutput
extension TestResultPresenter: TestResultInteractorOutput {
    
    func didSuccessObtainAnswers(_ answers: [[Int]]) {
        view?.hideHUD()
        rightAnswers = answers
        let viewModel = dataConverter.convert(rightAnswers: answers, userAnswers: userAnswers)
        mistakes = viewModel.mistakes
        view?.update(with: viewModel)
    }
    
    func didFailObtainAnswers(error: ErrorModel) {
        view?.hideHUD()
        view?.showErrorPlaceholder(error)
    }

}


// MARK: - TestResultTableViewManagerDelegate
extension TestResultPresenter: TestResultTableViewManagerDelegate {
    
    func didTapShowMistakes() {
        
        guard let mistakes = mistakes else {
            // TODO: - Обработать если ошибки еще не успели загрузиться
            return
        }
        
        router?.openMistakes(mistakes: mistakes, questions: questions, testId: testId)
    }
    
}
