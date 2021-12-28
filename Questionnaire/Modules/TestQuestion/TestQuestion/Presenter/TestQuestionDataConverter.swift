//
//  TestQuestionDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestQuestionDataConverterInput {
    
    func convert(question: Question,
                 currentQuestionNumber: Int,
                 questionsCount: Int,
                 remainQuestionsNumbers: [Int],
                 mistake: QuestionMistakeModel?) -> TestQuestionViewModel
}

final class TestQuestionDataConverter {
    
    // MARK: - Typealias
    
    typealias TitleCellConfigurator = TableCellConfigurator<TestQuestionTitleCell, TestQuestionTitleCell.Model>
    typealias AnswerCounterCellConfigurator = TableCellConfigurator<TestAnswersCounterCell, TestAnswersCounterCell.Model>
    typealias Row = TestQuestionViewModel.Row
    
    
    // MARK: - Private methods
    
    private func createTitleRow(title: String) -> Row {
        let model = TestQuestionTitleCell.Model(title: title)
        let configurator = TitleCellConfigurator(item: model)
        return .title(configurator)
    }
    
    private func createAnswerCounterRow(answers: [String],
                                        isMultipleAnswers: Bool,
                                        mistake: QuestionMistakeModel?) -> Row {

        let model = TestAnswersCounterCell.Model(answers: answers,
                                                 isMultipleAnswers: isMultipleAnswers,
                                                 rightAnswer: mistake?.rightAnswers,
                                                 wrongAnswer: mistake?.wrongAnswers)
        
        let configurator = AnswerCounterCellConfigurator(item: model)
        return .answerCounter(configurator)
    }
    
}


// MARK: - TestQuestionDataConverterInput
extension TestQuestionDataConverter: TestQuestionDataConverterInput {
    
    func convert(question: Question,
                 currentQuestionNumber: Int,
                 questionsCount: Int,
                 remainQuestionsNumbers: [Int],
                 mistake: QuestionMistakeModel?) -> TestQuestionViewModel {
        
        let titleRow = createTitleRow(title: question.text)
        let answersCounterRow = createAnswerCounterRow(answers: question.answers,
                                                       isMultipleAnswers: question.isMultipleAnswers,
                                                       mistake: mistake)
        
        let rows = [titleRow, answersCounterRow]
        
        let isSkipButtonEnabled: Bool
        let isReturnButtonEnabled: Bool
        
        if remainQuestionsNumbers.count == 1 {
            isSkipButtonEnabled = false
            isReturnButtonEnabled = false
        } else if currentQuestionNumber == remainQuestionsNumbers.last {
            isSkipButtonEnabled = false
            isReturnButtonEnabled = true
        } else if currentQuestionNumber == remainQuestionsNumbers.first {
            isSkipButtonEnabled = true
            isReturnButtonEnabled = false
        } else {
            isSkipButtonEnabled = true
            isReturnButtonEnabled = true
        }
        
        
        
        return TestQuestionViewModel(rows: rows,
                                     currentQuestionNumber: currentQuestionNumber,
                                     questionsCount: questionsCount,
                                     isSkipButtonEnabled: isSkipButtonEnabled,
                                     isReturnButtonEnabled: isReturnButtonEnabled,
                                     isMistakesShowing: mistake != nil)
    }

}
