//
//  FileStats.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class FileStats {
    let url: URL
    let dataString: String
    let name: String

    init(url: URL, dataString: String, name: String) {
        self.url = url
        self.dataString = dataString
        self.name = name
    }

    //  a frequency analysis of the top-20 most common consecutive one-character,
    //  two-character, and three-character patterns.
    var wordsDictionary: [String: Int] = [:]
    var ligatures1Character: [(String, Int)] = []
    var ligatures2Character: [(String, Int)] = []
    var ligatures3Character: [(String, Int)] = []

    var timeToAnalyze: Double? = nil {
        didSet { self.analysisComplete.toggle()}
    }

    var analysisComplete = false
}
