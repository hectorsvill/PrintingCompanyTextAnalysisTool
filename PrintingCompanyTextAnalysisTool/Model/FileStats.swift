//
//  FileStats.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

struct FileStats {
    let url: URL
    let dataString: String
    let name: String

    //  a frequency analysis of the top-20 most common consecutive one-character,
    //  two-character, and three-character patterns.
    var ligatures1Character: [String: Int] = [:] // [ 1 character : count ]
    var ligatures2Character: [String: Int] = [:] // [ 2 character : count ]
    var ligatures3Character: [String: Int] = [:] // [ 3 character : count ]
    var word: [String: Int] = [:] // [ word : count ]

    var timeToAnalyze: Int? = nil
}
