//
//  PrintingCompanyTextAnalysisToolUITests.swift
//  PrintingCompanyTextAnalysisToolUITests
//
//  Created by Hector Villasano on 7/20/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import XCTest

class PrintingCompanyTextAnalysisToolUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
    }
    
    func testNewInputFileButtonExist() {
        let newInputFileButton = app.buttons["NewInputFileButton"]
        XCTAssert(newInputFileButton.isHittable)
        newInputFileButton.tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
