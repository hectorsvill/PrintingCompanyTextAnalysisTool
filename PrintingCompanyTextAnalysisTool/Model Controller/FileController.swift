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



    func performFrequencyAnalysis(_ fileStats: FileStats) {
        let timer1 = Date()
        singleCharacterAnalysis(fileStats)

        let timer2 = Date()

        let time = timer2.timeIntervalSince1970 - timer1.timeIntervalSince1970
        print(time)
        fileStats.timeToAnalyze = time
    }

    func singleCharacterAnalysis(_ fileStats: FileStats) {

        let words = fileStats.dataString.split(separator: " ")
        for word in words {
            fileStats.words[ String(word), default: 0] += 1
        }


    }


}
