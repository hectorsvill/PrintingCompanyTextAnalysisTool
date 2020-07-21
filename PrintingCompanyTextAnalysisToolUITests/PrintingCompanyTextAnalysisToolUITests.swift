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
    
    var mainNavigationBar: XCUIElement {
        app.navigationBars["Frequency Analysis"]
    }
    
    var newInputFileButton: XCUIElement {
        app.buttons["NewInputFileButton"]
    }
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
    }
    
}

extension PrintingCompanyTextAnalysisToolUITests {
    
    func testNewInputFileButtonIsHittable() {
        XCTAssert(newInputFileButton.isHittable)
    }
    
    func testFilePickerIsHittableAllConfigurations() {
        newInputFileButton.tap()
        
        let filePickerNavBar = app.navigationBars["FullDocumentManagerViewControllerNavigationBar"]
        XCTAssert(filePickerNavBar.isHittable)
      
        #if DEBUG
        if CommandLine.arguments.contains("Configuration 1") {
            let filePickerNavBarCancelButton = filePickerNavBar.buttons["Cancel"]
            XCTAssert(filePickerNavBar.isHittable)
            filePickerNavBarCancelButton.tap()
        }else if CommandLine.arguments.contains("Spanish Configuration") {
            let filePickerNavBarCancelButton = filePickerNavBar.buttons["Cancelar"]
            XCTAssert(filePickerNavBar.isHittable)
            filePickerNavBarCancelButton.tap()
        }
        #endif
        
//        XCTAssert(mainNavigationBar.isHittable)
    }
}
