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
    
    private func findMistakesIn(userAnswers: [Int],
                                rightAnswers: [Int],
                                questionNumber: Int) -> QuestionMistakeModel {
        
        var selectedRightAnswers = [Int]()
        var missingRightAnswers = [Int]()
        var wrongAnswers = [Int]()
        let isMultiple = rightAnswers.count > 1

        for change in userAnswers.difference(from: rightAnswers) {
            
          switch change {
              
          case let .remove(_, oldElement, _):
              missingRightAnswers.append(oldElement)
              
          case let .insert(_, newElement, _):
              wrongAnswers.append(newElement)
          }
        }
        
        if isMultiple {
            rightAnswers.forEach({ answer in
                if userAnswers.contains(answer) {
                    selectedRightAnswers.append(answer)
                }
            })
        }
        
        return QuestionMistakeModel(questionNumber: questionNumber,
                                    wrongAnswers: wrongAnswers,
                                    selectedRightAnswers: selectedRightAnswers,
                                    missingRightAnswers: missingRightAnswers)
    }
    
    private func calculateResults(rightAnswers: [[Int]],
                                  userAnswers: [UserAnswerModel]) -> ResultsModel {
        
        var matches = 0
        var questionWithMistakes: [QuestionMistakeModel] = []
        
        userAnswers.forEach { userAnswer in
            
            let rightAnswer = rightAnswers[userAnswer.questionNumber - 1]
            
            if rightAnswer != userAnswer.answers {
                let mistake = findMistakesIn(userAnswers: userAnswer.answers,
                                             rightAnswers: rightAnswer,
                                             questionNumber: userAnswer.questionNumber)
                
                matches += mistake.selectedRightAnswers.count
                questionWithMistakes.append(mistake)
                
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
        
        return TestResultViewModel(rows: rows, mistakes: resultsModel.mistakes)
    }
    
}

// MARK: - ResultsModel
extension TestResultDataConverter {
    
    struct ResultsModel {
        
        let progressPercent: Double
        let mistakes: [QuestionMistakeModel]
    }
    
}
