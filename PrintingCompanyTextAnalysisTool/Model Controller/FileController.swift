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


}
