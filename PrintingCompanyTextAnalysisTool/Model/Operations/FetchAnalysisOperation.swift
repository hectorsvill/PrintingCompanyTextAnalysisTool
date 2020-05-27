//
//  FetchAnalysisOperation.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/26/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class FetchAnalysisOperation: ConcurrentOperation {
    var fileStats: FileStats
    var isCanceled = false

    init(fileStats: FileStats) {
        self.fileStats = fileStats
    }


    override func start() {
        state = .isExecuting

        let timer1 = Date()

        characterAnalysis(fileStats)

        fileStats.timeToAnalyze = Date().timeIntervalSince1970 - timer1.timeIntervalSince1970

        fileStats.analysisComplete = true

        state = .isFinished

    }

    override func cancel() {
        isCanceled = true
        fileStats.ligatures1Character = []
        fileStats.ligatures2Character = []
        fileStats.ligatures3Character = []
    }
}

extension FetchAnalysisOperation {
    private func characterAnalysis(_ fileStats: FileStats) {
        var singleChardictionary: [String: Int] = [:]
        var doubleChardictionary: [String: Int] = [:]
        var tripleChardictionary: [String: Int] = [:]

        let stringArray = Array(fileStats.dataString)
        var index = 0

        while index < stringArray.count{
            let firstCharacter = stringArray[index]
            let secondCharacter: String.Element! = index < stringArray.count - 1 ? stringArray[index + 1] : nil
            let thirdCharacter: String.Element! = index < stringArray.count - 2 ? stringArray[index + 2] : nil

            if firstCharacter >= "!" && firstCharacter <= "~" {

                singleChardictionary[String(firstCharacter), default: 0] += 1

                if index < stringArray.count - 1 && secondCharacter >= "!" && secondCharacter <= "~" {

                    doubleChardictionary[String([firstCharacter, secondCharacter]), default: 0] += 1

                    if index < stringArray.count - 2 && thirdCharacter >= "!" && thirdCharacter <= "~" {

                        tripleChardictionary[String([firstCharacter, secondCharacter, thirdCharacter]), default: 0] += 1

                    }
                }
            }

            if isCanceled { break }

            index += 1
        }

        if !isCanceled {
            fileStats.ligatures1Character = sortDictionary(singleChardictionary)
            fileStats.ligatures2Character = sortDictionary(doubleChardictionary)
            fileStats.ligatures3Character = sortDictionary(tripleChardictionary)
        }
    }


    func sortDictionary(_ dictionary: [String: Int]) -> [(String, Int)] {
          let sortedList = dictionary.sorted { $0.value > $1.value }
          var values: [(String,Int)] = []

          for (index, item) in sortedList.enumerated() {
              if index == 20 {
                  break
              }
              let dict = Dictionary(dictionaryLiteral: item)
              let str = dict.keys.first!
              let value = dict.values.first!
              values.append((str, value))

            if isCanceled { break }
          }
        
        return isCanceled ? [] : values
      }
}
