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
    
    private func calculateMatches(rightAnswers: [[Int]], userAnswers: [UserAnswerModel]) -> Int {
        
        var matches = 0
       // var questionWithMistakes = [Int]()
        
        userAnswers.forEach { userAnswer in
            
            let rightAnswer = rightAnswers[userAnswer.questionNumber - 1]
            
            if rightAnswer.count == 1, rightAnswer.first == userAnswer.answers.first {
                matches += 1
                
            } else if rightAnswer.count > 1 {
                rightAnswer.forEach { answer in
                    if userAnswer.answers.filter({ $0 == answer }).first != nil {
                        matches += 1
                    }
                }
            }
        }
        
        return matches
    }

}


// MARK: - TestResultDataConverterInput
extension TestResultDataConverter: TestResultDataConverterInput {
  
    func convert(rightAnswers: [[Int]], userAnswers: [UserAnswerModel]) -> TestResultViewModel {
        
        let allAnswers = rightAnswers.flatMap { $0 }
        let matches = calculateMatches(rightAnswers: rightAnswers, userAnswers: userAnswers)
        let progressPercent = Double(matches) / Double(allAnswers.count)
        let cirlceProgressRow = createCircleProgressRow(progressPercent: progressPercent)
      //  let mistakesRow = createMistakesRow(mistakesNumbers: questionWithMistakes)
        let rows = [cirlceProgressRow]
        
        return TestResultViewModel(rows: rows, finishButtonTitle: "Завершить тест")
    }
    
}
