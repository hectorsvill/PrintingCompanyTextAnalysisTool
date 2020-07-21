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
    
    var filePickerNavigationBar: XCUIElement {
        app.navigationBars["FullDocumentManagerViewControllerNavigationBar"]
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
        
        XCTAssert(filePickerNavigationBar.isHittable)
      
        #if DEBUG
        if CommandLine.arguments.contains("Configuration 1") {
            testFilePickerIsHittableAllConfigurations_Configuration1()
        } else if CommandLine.arguments.contains("Spanish Configuration") {
            testFilePickerIsHittableAllConfigurations_SpanishConfiguration()
        }
        
        #endif
    }
    
    private func testFilePickerIsHittableAllConfigurations_Configuration1() {
        let filePickerNavBarCancelButton = filePickerNavigationBar.buttons["Cancel"]
        XCTAssert(filePickerNavBarCancelButton.isHittable)
        filePickerNavBarCancelButton.tap()
        XCTAssert(mainNavigationBar.isHittable)
    }
    
    private func testFilePickerIsHittableAllConfigurations_SpanishConfiguration() {
        let filePickerNavBarCancelButton = filePickerNavigationBar.buttons["Cancelar"]
        XCTAssert(filePickerNavBarCancelButton.isHittable)
        filePickerNavBarCancelButton.tap()
        XCTAssert(mainNavigationBar.isHittable)
    }
}
