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
        performFrequencyAnalysis(fileStats)
    }

    func removeFile(_ index: Int) {
        fileStatsList.remove(at: index)
    }


    func performFrequencyAnalysis(_ fileStats: FileStats) {
        let timer1 = Date()

        singleCharacterAnalysis(fileStats)
        let timer2 = Date()
        fileStats.timeToAnalyze = timer2.timeIntervalSince1970 - timer1.timeIntervalSince1970
    }


    func singleCharacterAnalysis(_ fileStats: FileStats) {
        var singleChardictionary: [String: Int] = [:]
        let dataString = fileStats.dataString


        dataString.forEach {
            if $0 >= "A" && $0 <= "z" {
                singleChardictionary[String($0), default: 0] += 1
            }

        }

        let sortedArr = sortDictionary(singleChardictionary)
        fileStats.ligatures1Character = sortedArr
    }

    func doubleCharacterAnalysis(_ fileStats: FileStats) {
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
