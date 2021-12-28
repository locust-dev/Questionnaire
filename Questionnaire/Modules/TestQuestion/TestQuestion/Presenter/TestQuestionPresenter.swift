//
//  TestQuestionPresenter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestQuestionViewOutput: ViewOutput {
    func didTapConfirmButton()
    func didTapFinishButton()
    func didTapSkipQuestion()
    func didTapReturnQuestion()
    func didTapCloseButtton()
}

final class TestQuestionPresenter {
    
    // MARK: - Properties
    
    weak var view: TestQuestionViewInput?
    
    var router: TestQuestionRouterInput?
    
    private var userAnswers: [UserAnswerModel] = []
    private var currentUserAnswers: [Int]?
    private var remainQuestionsNumbers: [Int] = []
    private var currentQuestionNumber = 1
    
    private let dataConverter: TestQuestionDataConverterInput
    private let questions: [Question]
    private let testId: String
    private let mistakes: [QuestionMistakeModel]?
    
    
    // MARK: - Init
    
    init(dataConverter: TestQuestionDataConverterInput,
         questions: [Question],
         testId: String,
         mistakes: [QuestionMistakeModel]?) {
        
        self.dataConverter = dataConverter
        self.questions = questions
        self.testId = testId
        self.mistakes = mistakes
    }
    
    
    // MARK: - Private methods
    
    private func setQuestion() {
        
        guard let question = questions[safe: currentQuestionNumber - 1] else {
            return
        }
        
        var mistake: QuestionMistakeModel?
        
        if let mistakes = mistakes {
            mistake = mistakes.first(where: { $0.questionNumber == currentQuestionNumber })

        } else {
            currentUserAnswers = nil
        }
        
        let model = dataConverter.convert(question: question,
                                          currentQuestionNumber: currentQuestionNumber,
                                          questionsCount: questions.count,
                                          remainQuestionsNumbers: remainQuestionsNumbers,
                                          mistake: mistake)
        view?.update(with: model)
    }
    
    private func navigateToNextQuestion() {
        
        if remainQuestionsNumbers.isEmpty {
            router?.openResults(questions: questions, userAnswers: userAnswers, testId: testId)
            
        } else if remainQuestionsNumbers.count == 1 {
            currentQuestionNumber = remainQuestionsNumbers.first!
            setQuestion()
            
        } else {
            if !moveToClosedNextQuestion() {
                moveToClosedLastQuestion()
            }
        }
    }
    
    @discardableResult
    private func moveToClosedNextQuestion() -> Bool {
        
        for questionNumber in remainQuestionsNumbers {
            if questionNumber > currentQuestionNumber {
                currentQuestionNumber = questionNumber
                setQuestion()
                return true
            }
        }
        
        return false
    }
    
    @discardableResult
    private func moveToClosedLastQuestion() -> Bool {
        
        let reversedNumbers = Array(remainQuestionsNumbers.reversed())
        
        for questionNumber in reversedNumbers {
            if questionNumber < currentQuestionNumber {
                currentQuestionNumber = questionNumber
                setQuestion()
                return true
            }
        }
        
        return false
    }
    
}


// MARK: - TestQuestionViewOutput
extension TestQuestionPresenter: TestQuestionViewOutput {
    
    func viewIsReady() {
        
        if let mistakes = mistakes {
            remainQuestionsNumbers = mistakes.map { $0.questionNumber }
            currentQuestionNumber = remainQuestionsNumbers.first ?? 1
        } else {
            remainQuestionsNumbers = Array(1...questions.count)
        }
        
        view?.hideTabBar()
        setQuestion()
    }
    
    func didTapConfirmButton() {
        
        guard let currentUserAnswers = currentUserAnswers,
              let index = remainQuestionsNumbers.firstIndex(of: currentQuestionNumber),
              !currentUserAnswers.isEmpty
        else {
            view?.showNotConfirmAlert()
            return
        }
        
        let userAnswer = UserAnswerModel(questionNumber: currentQuestionNumber,
                                         answers: currentUserAnswers)
        
        userAnswers.append(userAnswer)
        remainQuestionsNumbers.remove(at: index)
        navigateToNextQuestion()
    }
    
    func didTapFinishButton() {
        router?.closeModule()
        view?.showTabBar()
    }
    
    func didTapSkipQuestion() {
        moveToClosedNextQuestion()
    }
    
    func didTapReturnQuestion() {
        moveToClosedLastQuestion()
    }
    
    func didTapCloseButtton() {
        router?.closeModule()
    }
    
}


// MARK: - TestQuestionTableViewManagerDelegate
extension TestQuestionPresenter: TestQuestionTableViewManagerDelegate {
    
    func didSelectAnswers(_ answers: [Int]) {
        currentUserAnswers = answers
    }
}
