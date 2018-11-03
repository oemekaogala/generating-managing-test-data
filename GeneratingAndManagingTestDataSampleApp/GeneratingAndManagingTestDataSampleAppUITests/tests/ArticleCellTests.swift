//
//  GeneratingAndManagingTestDataSampleAppUITests.swift
//  GeneratingAndManagingTestDataSampleAppUITests
//
//  Created by Omose Ogala on 11/1/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import XCTest

class ArticleCellTests: XCTestCase {
    
    let app = XCUIApplication()
    let expectedArticleHeadline = "Trump plans to block migrants from claiming asylum between legal ports of entry"
    let mockedJsonFilename = "mockedNewsArticles.json"
    
    override func setUp() {
        continueAfterFailure = false
        
        // Set launch arguments
        app.launchArguments.append(TestingConstants.isTestArg)
        app.launchArguments.append(TestingConstants.mockedJsonArg)
        
        // Pass json for test
        let mockedJsonString = Utils.getJsonString(fileName: mockedJsonFilename, testCase: self)
        app.launchArguments.append(mockedJsonString)
        
        app.launch()
    }
    
    func testFullHeadlineDisplays() {
        let firstCell = app.cells.firstMatch
        let currentArticleHeadline = firstCell.staticTexts[TestingConstants.headlineAccessibilityId].label
        
        XCTAssert(expectedArticleHeadline == currentArticleHeadline, "The title was not displayed correctly")
    }
}
