//
//  FileStats.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class FileStats: ObservableObject {
    let index: Int //0 based
    let url: URL
    let dataString: String
    let name: String

    init(index: Int, url: URL, dataString: String, name: String) {
        self.index = index
        self.url = url
        self.dataString = dataString
        self.name = name
    }

    var timeToAnalyze: Double? = nil
    var chartState: State = .isExecuting
    //  a frequency analysis of the top-20 most common consecutive one-character,
    //  two-character, and three-character patterns.
    var ligatures1Character: [(String, Int)] = []
    var ligatures2Character: [(String, Int)] = []
    var ligatures3Character: [(String, Int)] = []

    enum State: String {
        case isExecuting, isFinished, isCancelled
    }

    var stateDescription: String {
        var description = ""

        if chartState == .isExecuting {
            description = "Analyzing"
        } else if chartState == .isFinished {
            description = "Complete"
        } else if chartState == .isCancelled {
            description = "Analysis Canceled"
        }

        return description
    }

    var chart: [[(String, Int)]] {
        return [ligatures1Character, ligatures2Character, ligatures3Character]
    }

}
