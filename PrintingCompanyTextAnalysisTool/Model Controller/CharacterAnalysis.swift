//
//  FileController.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

struct CharacterAnalysis {
    let queue = DispatchQueue(label: "com.hectorstevenvillasano.PrintingCompanyTextAnalysisTool.CharacterAnalysisQueue")
    /// characterAnalysis: takes in String to check for 1 character, 2 character, 3 charater ligatuures. Returns a 2 dimensinal array of the tio 20 ligatuers for each category
    func characterAnalysis(_ fileStats: String) -> [[(String, Int)]] {
        var singleChardictionary: [String: Int] = [:]
        var doubleChardictionary: [String: Int] = [:]
        var tripleChardictionary: [String: Int] = [:]

        let stringArray = Array(fileStats)
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

            index += 1
        }

        return queue.sync { [sortDictionary(singleChardictionary),
                sortDictionary(doubleChardictionary),
                sortDictionary(tripleChardictionary)] }

    }

    // sortDictionary: returns a sorted array of top 20 ligatures
    private func sortDictionary(_ dictionary: [String: Int]) -> [(String, Int)] {
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
          }

        return values
      }
}
