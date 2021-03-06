//
//  TestQuestionDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import CoreGraphics
import UIKit

protocol TestQuestionDataConverterInput {
    
    func convert(question: Question,
                 animateDirection: Direction,
                 currentQuestionNumber: Int,
                 questionsCount: Int,
                 remainQuestionsNumbers: [Int],
                 mistake: QuestionMistakeModel?) -> TestQuestionViewModel
}

final class TestQuestionDataConverter {
    
    // MARK: - Locals
    
    private enum Locals {
        
        enum AnswersCell {

            static let stackInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            static let stackSpacing: CGFloat = 15
            static let buttonHeight: CGFloat = 50
        }
    }
    
    
    // MARK: - Typealias
    
    typealias ExplanationCellConfigurator = TableCellConfigurator<TestQuestionExplanationCell, TestQuestionExplanationCell.Model>
    typealias TitleCellConfigurator = TableCellConfigurator<TestQuestionTitleCell, TestQuestionTitleCell.Model>
    typealias AnswerCounterCellConfigurator = TableCellConfigurator<TestAnswersCounterCell, TestAnswersCounterCell.Model>
    typealias CodeSampleCellConfigurator = TableCellConfigurator<CodeSampleCell, CodeSampleCell.Model>
    typealias Row = TestQuestionViewModel.Row
    
    
    // MARK: - Private methods
    
    private func createTitleRow(title: String) -> Row {
        let model = TestQuestionTitleCell.Model(title: title)
        let configurator = TitleCellConfigurator(item: model)
        return .title(configurator)
    }
    
    private func createExplanationRow(text: String?) -> Row? {
        
        guard let text = text else {
            return nil
        }

        let model = TestQuestionExplanationCell.Model(explanationText: text)
        let configurator = ExplanationCellConfigurator(item: model)
        return .explanation(configurator)
    }
    
    private func createAnswerCounterRow(answers: [String],
                                        isMultipleAnswers: Bool,
                                        mistake: QuestionMistakeModel?) -> Row {

        let model = TestAnswersCounterCell.Model(answers: answers,
                                                 isMultipleAnswers: isMultipleAnswers,
                                                 stackSpacing: Locals.AnswersCell.stackSpacing,
                                                 stackInsets: Locals.AnswersCell.stackInsets,
                                                 questionMistakeModel: mistake)
        
        let configurator = AnswerCounterCellConfigurator(item: model)
        return .answerCounter(configurator)
    }
    
    private func createCodeSampleRow(with imagePath: String?) -> Row? {
        
        guard let imagePath = imagePath else {
            return nil
        }

        let model = CodeSampleCell.Model(codeSampleImagePath: imagePath)
        let configurator = CodeSampleCellConfigurator(item: model)
        return .codeSample(configurator)
    }
    
}


// MARK: - TestQuestionDataConverterInput
extension TestQuestionDataConverter: TestQuestionDataConverterInput {
    
    func convert(question: Question,
                 animateDirection: Direction,
                 currentQuestionNumber: Int,
                 questionsCount: Int,
                 remainQuestionsNumbers: [Int],
                 mistake: QuestionMistakeModel?) -> TestQuestionViewModel {
        
        let titleRow = createTitleRow(title: question.text)
        let codeSampleRow = createCodeSampleRow(with: question.codeSampleImage)
        let explanationRow = createExplanationRow(text: mistake?.explanation)
        let answersCounterRow = createAnswerCounterRow(answers: question.answers,
                                                       isMultipleAnswers: question.isMultipleAnswers,
                                                       mistake: mistake)
        
        let rows = [titleRow, codeSampleRow, answersCounterRow, explanationRow].compactMap { $0 }
        
        var isSkipButtonEnabled = remainQuestionsNumbers.count != 1
        var isReturnButtonEnabled = remainQuestionsNumbers.count != 1
        
        if currentQuestionNumber == remainQuestionsNumbers.last {
            isSkipButtonEnabled = false
            
        } else if currentQuestionNumber == remainQuestionsNumbers.first {
            isReturnButtonEnabled = false
        }
        
        return TestQuestionViewModel(rows: rows,
                                     currentQuestionNumber: currentQuestionNumber,
                                     questionsCount: questionsCount,
                                     isSkipButtonEnabled: isSkipButtonEnabled,
                                     isReturnButtonEnabled: isReturnButtonEnabled,
                                     isMistakesShowing: mistake != nil,
                                     swipeDirection: animateDirection)
    }

}
