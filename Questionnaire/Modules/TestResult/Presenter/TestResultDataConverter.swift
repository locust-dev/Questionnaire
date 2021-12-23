//
//  TestResultDataConverter.swift
//  Questionnaire
//
//  Created Ilya Turin on 14.12.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

protocol TestResultDataConverterInput {
    func convert(rightAnswers: [Int], userAnswers: [Int: Int]) -> TestResultViewModel
}

final class TestResultDataConverter {
    
    // MARK: - Properties
    
    let numberFormatter = NumberFormatter()
    
    
    // MARK: - Typealias
    
    typealias CircleProgressCellConfigurator = TableCellConfigurator<TestResultCircleProgressCell, TestResultCircleProgressCell.Model>
    typealias MistakesCellConfigurator = TableCellConfigurator<TestResultMistakesCell, TestResultMistakesCell.Model>
    
    
    // MARK: - Private methods
 
    private func createCircleProgressRow(progressPercent: Double) -> TestResultViewModel.Row {
        let model = TestResultCircleProgressCell.Model(progressPercent: progressPercent)
        let configurator = CircleProgressCellConfigurator(item: model)
        return .circleProgress(configurator)
    }
    
    private func createMistakesRow(mistakesNumbers: [Int]) -> TestResultViewModel.Row {
        let model = TestResultMistakesCell.Model(mistakesNumbers: mistakesNumbers.sorted(by: <))
        let configurator = MistakesCellConfigurator(item: model)
        return .mistakes(configurator)
    }
    
    private func convertToPercent(_ number: Float) -> String? {
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(from: NSNumber(value: number))
    }

}


// MARK: - TestResultDataConverterInput
extension TestResultDataConverter: TestResultDataConverterInput {
  
    func convert(rightAnswers: [Int], userAnswers: [Int : Int]) -> TestResultViewModel {
        
        var matches = 0
        var questionWithMistakes = [Int]()
        
        userAnswers.forEach { (questionNumber, userAnswer) in
            if rightAnswers[questionNumber - 1] == userAnswer {
                matches += 1
            } else {
                questionWithMistakes.append(questionNumber)
            }
        }
        
        let cirlceProgressRow = createCircleProgressRow(progressPercent: (Double(matches) / Double(rightAnswers.count)))
        let mistakesRow = createMistakesRow(mistakesNumbers: questionWithMistakes)
        let rows = [cirlceProgressRow, mistakesRow]
        
        return TestResultViewModel(rows: rows, finishButtonTitle: "Завершить тест")
    }
    
}
