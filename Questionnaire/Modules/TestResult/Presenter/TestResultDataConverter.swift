//
//  TestResultDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

protocol TestResultDataConverterInput {
    func convert(rightAnswers: [[Int]], userAnswers: [UserAnswerModel]) -> TestResultViewModel
}

final class TestResultDataConverter {
    
    // MARK: - Properties
    
    let numberFormatter = NumberFormatter()
    
    
    // MARK: - Typealias
    
    typealias CircleProgressCellConfigurator = TableCellConfigurator<TestResultCircleProgressCell, TestResultCircleProgressCell.Model>
    typealias MistakesCellConfigurator = TableCellConfigurator<TestResultMistakesCell, TestResultMistakesCell.Model>
    typealias Row = TestResultViewModel.Row
    
    
    // MARK: - Private methods
    
    private func createCircleProgressRow(progressPercent: Double) -> Row {
        let model = TestResultCircleProgressCell.Model(progressPercent: progressPercent)
        let configurator = CircleProgressCellConfigurator(item: model)
        return .circleProgress(configurator)
    }
    
    private func createMistakesRow(mistakesCount: Int) -> Row {
        let model = TestResultMistakesCell.Model(mistakesCount: mistakesCount)
        let configurator = MistakesCellConfigurator(item: model)
        return .mistakes(configurator)
    }
    
    private func convertToPercent(_ number: Float) -> String? {
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
    private func findMistakes<T: Hashable>(_ userAnswers: [T], _ rightAnswers: [T]) -> [T]? {
        
        var wrongAnswers = [T]()
        
        userAnswers.forEach { number in
            
            if rightAnswers.first(where: { $0 == number }) == nil {
                wrongAnswers.append(number)
            }
        }
        
        return wrongAnswers.isEmpty ? nil : wrongAnswers
    }
    
    private func calculateResults(rightAnswers: [[Int]],
                                  userAnswers: [UserAnswerModel]) -> ResultsModel {
        
        var matches = 0
        var questionWithMistakes: [QuestionMistakeModel] = []
        
        userAnswers.forEach { userAnswer in
            
            let rightAnswer = rightAnswers[userAnswer.questionNumber - 1]
            
            if let mistakes = findMistakes(userAnswer.answers, rightAnswer) {
                let mistakeModel = QuestionMistakeModel(
                    rightAnswers: rightAnswer,
                    wrongAnswers: mistakes,
                    questionNumber: userAnswer.questionNumber
                )
                questionWithMistakes.append(mistakeModel)
                
            } else {
                matches += rightAnswer.count
            }
        }
        
        let allAnswers = rightAnswers.flatMap { $0 }
        let progressPercent = Double(matches) / Double(allAnswers.count)
        let resultsModel = ResultsModel(progressPercent: progressPercent,
                                        mistakes: questionWithMistakes)
        
        return resultsModel
    }
    
}


// MARK: - TestResultDataConverterInput
extension TestResultDataConverter: TestResultDataConverterInput {
    
    func convert(rightAnswers: [[Int]], userAnswers: [UserAnswerModel]) -> TestResultViewModel {
        
        var rows: [Row] = []
        
        let resultsModel = calculateResults(rightAnswers: rightAnswers, userAnswers: userAnswers)
        
        let cirlceProgressRow = createCircleProgressRow(progressPercent: resultsModel.progressPercent)
        rows.append(cirlceProgressRow)
        
        if !resultsModel.mistakes.isEmpty {
            let mistakesRow = createMistakesRow(mistakesCount: resultsModel.mistakes.count)
            rows.append(mistakesRow)
        }
        
        return TestResultViewModel(rows: rows, finishButtonTitle: "Завершить тест", mistakes: resultsModel.mistakes)
    }
    
}

// MARK: - ResultsModel
extension TestResultDataConverter {
    
    struct ResultsModel {
        
        let progressPercent: Double
        let mistakes: [QuestionMistakeModel]
    }
    
}
