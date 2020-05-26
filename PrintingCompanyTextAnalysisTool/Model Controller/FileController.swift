//
//  FileController.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class FileControrller {
    private (set) var fileStatsList = [FileStats]()

    func addFile(_ fileStats: FileStats) {
        fileStatsList.append(fileStats)
    }

    func removeFile(_ index: Int) {
        fileStatsList.remove(at: index)
    }


    func performFrequencyAnalysis(_ fileStats: FileStats) {
        let timer1 = Date()

        characterAnalysis(fileStats)

        let timer2 = Date()
        fileStats.timeToAnalyze = timer2.timeIntervalSince1970 - timer1.timeIntervalSince1970
    }

    func characterAnalysis(_ fileStats: FileStats) {
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


            index += 1
        }

        fileStats.ligatures1Character = sortDictionary(singleChardictionary)
        fileStats.ligatures2Character = sortDictionary(doubleChardictionary)
        fileStats.ligatures3Character = sortDictionary(tripleChardictionary)
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

        }

        return values
    }
}
