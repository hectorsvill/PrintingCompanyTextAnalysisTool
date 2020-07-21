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
    
    var newInputFileButton: XCUIElement {
        return app.buttons["NewInputFileButton"]
    }

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
    }
    
    func testNewInputFileButtonIsHittable() {
        XCTAssert(newInputFileButton.isHittable)
        newInputFileButton.tap()
    }
}
