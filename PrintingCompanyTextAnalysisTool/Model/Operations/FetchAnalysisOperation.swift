//
//  FetchAnalysisOperation.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/26/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class FetchAnalysisOperation: ConcurrentOperation {
    var fileStatsDataString: String
    var timeToAnalyze: Double? = nil
    var ligatures1Character: [(String, Int)] = []
    var ligatures2Character: [(String, Int)] = []
    var ligatures3Character: [(String, Int)] = []
    var isCanceled = false

    init(fileStatsDataString: String) {
        self.fileStatsDataString = fileStatsDataString
    }


    override func start() {
        state = .isExecuting

        let timer1 = Date()
        
        let chart = CharacterAnalysis().characterAnalysis(fileStatsDataString)
        ligatures1Character = chart[0]
        ligatures2Character = chart[1]
        ligatures3Character = chart[2]

        timeToAnalyze = Date().timeIntervalSince1970 - timer1.timeIntervalSince1970

        state = .isFinished
    }

    override func cancel() {
        super.cancel()
        timeToAnalyze = nil
        ligatures1Character = []
        ligatures2Character = []
        ligatures3Character = []
    }
}
