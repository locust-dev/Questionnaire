//
//  TestQuestionDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestQuestionDataConverterInput {
    func convert(question: Question, currentQuestionNumber: Int, questionsCount: Int) -> TestQuestionViewModel
}

final class TestQuestionDataConverter {
    
    // MARK: - Typealias
    
    typealias TitleCellConfigurator = TableCellConfigurator<TestQuestionTitleCell, TestQuestionTitleCell.Model>
    typealias AnswerCounterCellConfigurator = TableCellConfigurator<TestAnswersCounterCell, TestAnswersCounterCell.Model>
    
    
    // MARK: - Private methods
    
    private func createTitleRow(title: String) -> TestQuestionViewModel.Row {
        let model = TestQuestionTitleCell.Model(title: title)
        let configurator = TitleCellConfigurator(item: model)
        return .title(configurator)
    }
    
    private func createAnswerCounterRow(answers: [String]) -> TestQuestionViewModel.Row {
        let model = TestAnswersCounterCell.Model(answers: answers)
        let configurator = AnswerCounterCellConfigurator(item: model)
        return .answerCounter(configurator)
    }
    
}


// MARK: - TestQuestionDataConverterInput
extension TestQuestionDataConverter: TestQuestionDataConverterInput {
    
    func convert(question: Question, currentQuestionNumber: Int, questionsCount: Int) -> TestQuestionViewModel {
        
        let titleRow = createTitleRow(title: question.text)
        let answersCounterRow = createAnswerCounterRow(answers: question.answers)
        
        let rows = [titleRow, answersCounterRow]
        
        return TestQuestionViewModel(rows: rows, currentQuestionNumber: currentQuestionNumber, questionsCount: questionsCount)
    }
    
}
