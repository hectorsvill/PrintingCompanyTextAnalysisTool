//
//  PrintingCompanyTextAnalysisToolUITestsMetrics.swift
//  PrintingCompanyTextAnalysisToolUITests
//
//  Created by Hector Villasano on 7/21/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import XCTest

class PrintingCompanyTextAnalysisToolUITestsMetrics: XCTestCase {
    var app: XCUIApplication! = nil
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {}

    func testExample() throws {}

}

extension PrintingCompanyTextAnalysisToolUITestsMetrics {
    func testAplicationLunchTime() {
        measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
            app.launch()
        }
    }
}

