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

        singleCharacterAnalysis(fileStats)
        doubleCharacterAnalysis(fileStats)
        tripleCharacterAnalysis(fileStats)

        let timer2 = Date()
        fileStats.timeToAnalyze = timer2.timeIntervalSince1970 - timer1.timeIntervalSince1970
    }

    func singleCharacterAnalysis(_ fileStats: FileStats) {
        var singleChardictionary: [String: Int] = [:]

        let stringArray = Array(fileStats.dataString)
        var index = 0

        while index < stringArray.count {
            let character = stringArray[index]

            if character >= "!" && character <= "~" {
                singleChardictionary[String(character), default: 0] += 1
            }

            index += 1
        }

        let sortedArr = sortDictionary(singleChardictionary)
        fileStats.ligatures1Character = sortedArr
    }

    func doubleCharacterAnalysis(_ fileStats: FileStats) {
        var singleChardictionary: [String: Int] = [:]

        let stringArray = Array(fileStats.dataString)
        var index = 0
        while index < stringArray.count - 1{
            let character = stringArray[index]
            let nextCharacter = stringArray[index + 1]

            if character >= "!" && character <= "~" && nextCharacter >= "!" && nextCharacter <= "~" {
                singleChardictionary[String([character, nextCharacter]), default: 0] += 1
            }

            index += 1
        }
        
        let sortedArr = sortDictionary(singleChardictionary)
        fileStats.ligatures2Character = sortedArr
    }

    func tripleCharacterAnalysis(_ fileStats: FileStats) {
        var singleChardictionary: [String: Int] = [:]

        let stringArray = Array(fileStats.dataString)
        var index = 0
        while index < stringArray.count - 2{
            let character = stringArray[index]
            let secondCharacter = stringArray[index + 1]
            let thirdCharacter = stringArray[index + 2]

            if character >= "!" && character <= "~" && secondCharacter >= "!" && secondCharacter <= "~" && thirdCharacter >= "!" && thirdCharacter <= "~" {
                singleChardictionary[String([character, secondCharacter, thirdCharacter]), default: 0] += 1
            }

            index += 1
        }

        let sortedArr = sortDictionary(singleChardictionary)
        fileStats.ligatures3Character = sortedArr
        print(sortedArr)

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
