//
//  PrintingCompanyTextAnalysisToolUnitTestMetrics.swift
//  PrintingCompanyTextAnalysisToolUnitTest
//
//  Created by Hector Villasano on 7/21/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import XCTest

// MARK: Metrics
extension PrintingCompanyTextAnalysisToolUnitTest {
    func testPerformancee() throws {
        self.measure {
            _ = fetchChart(fileStats1!)
        }
    }
    
    func testFetchChartCPUMetric() {
        measure(metrics: [XCTCPUMetric()]) {
            _ = fetchChart(fileStats1!)
        }
    }
    
    func testFetchChartMemoryMetric() {
        measure(metrics: [XCTMemoryMetric()]) {
            _ = fetchChart(fileStats1!)
        }
    }
}
