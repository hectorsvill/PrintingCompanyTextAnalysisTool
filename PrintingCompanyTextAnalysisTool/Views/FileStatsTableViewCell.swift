//
//  FileStatsTableViewCell.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/26/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import UIKit

class FileStatsTableViewCell: UITableViewCell {
    var fileStats: FileStats? { didSet { configureViews() }}

    func configureViews() {
        guard let fileStats = fileStats else { return }

        textLabel?.text =  fileStats.stateDescription
        textLabel?.font = .systemFont(ofSize: 11)
        textLabel?.textColor = .systemGray

        if let timeToAnalyze = fileStats.timeToAnalyze {
            detailTextLabel?.text =  String(format: "Time: %0.5F", timeToAnalyze)
        }
    }
}
