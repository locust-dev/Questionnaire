//
//  TestQuestionMistakeDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 22.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

protocol TestQuestionMistakeDataConverterInput {
    func convert(questionMistakeModel: QuestionMistakeModel) -> TestQuestionMistakeViewModel
}

final class TestQuestionMistakeDataConverter {
    
    // MARK: - Typealias
    
    typealias TitleCellConfigurator = TableCellConfigurator<TestQuestionTitleCell, TestQuestionTitleCell.Model>
    typealias AnswerCounterCellConfigurator = TableCellConfigurator<TestQuestionMistakeAnswersCell, TestQuestionMistakeAnswersCell.Model>
    
    
    // MARK: - Private methods
    
    private func createTitleRow(title: String) -> TestQuestionMistakeViewModel.Row {
        let model = TestQuestionTitleCell.Model(title: title)
        let configurator = TitleCellConfigurator(item: model)
        return .title(configurator)
    }
    
}


// MARK: - TestQuestionMistakeDataConverterInput
extension TestQuestionMistakeDataConverter: TestQuestionMistakeDataConverterInput {
    
    func convert(questionMistakeModel: QuestionMistakeModel)-> TestQuestionMistakeViewModel {
        
        let titleRow = createTitleRow(title: questionMistakeModel.question.text)
        
        let model = TestQuestionMistakeAnswersCell.Model(answers: questionMistakeModel.question.answers,
                                                         rightAnswer: questionMistakeModel.rightAnswer,
                                                         wrongAnswer: questionMistakeModel.wrongAnswer)
        
        let configurator = AnswerCounterCellConfigurator(item: model)
        let answersCounterRow = TestQuestionMistakeViewModel.Row.answerCounter(configurator)
        
        let rows = [titleRow, answersCounterRow]
        
        return TestQuestionMistakeViewModel(rows: rows,
                                            currentQuestionNumber: questionMistakeModel.currentQuestionNumber,
                                            questionsCount: questionMistakeModel.questionsCount)
    }
    
}
