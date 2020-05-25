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

        wordAnalysis(fileStats)
        singleCharacterAnalysis(fileStats)


        let timer2 = Date()
        fileStats.timeToAnalyze = timer2.timeIntervalSince1970 - timer1.timeIntervalSince1970
    }

    func wordAnalysis(_ fileStats: FileStats) {
        let words = fileStats.dataString.split(separator: " ")
        words.forEach {
            fileStats.wordsDictionary[ String($0), default: 0] += 1
        }
    }

    func singleCharacterAnalysis(_ fileStats: FileStats) {
        var dictionary: [String: Int] = [:]
        fileStats.dataString.forEach {
            if let asciiValue = $0.asciiValue {
                if asciiValue >= 65 && asciiValue <= 122 {
                    dictionary[String($0), default: 0] += 1
                }
            }
        }

        let sortedArr = sortDictionary(dictionary)
        fileStats.ligatures1Character = sortedArr
    }

    func sortDictionary(_ dictionary: [String: Int]) -> [(String, Int)] {
        let sortedList = dictionary.sorted { $0.value > $1.value }[0..<20]

        var values: [(String,Int)] = []

        for item in sortedList {
            let dict = Dictionary(dictionaryLiteral: item)
            let str = dict.keys.first!
            let value = dict.values.first!
            values.append((str, value))
        }

        return values
    }

}
