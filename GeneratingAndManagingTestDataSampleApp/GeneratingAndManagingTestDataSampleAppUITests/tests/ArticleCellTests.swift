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
    var expectedArticleHeadline = ""
    
    // When using a json fixture instead of AppDataGenerator
    // var expectedArticleHeadline = "Trump plans to block migrants from claiming asylum between legal ports of entry"
    // let mockedJsonFilename = "mockedNewsArticles.json"
    
    override func setUp() {
        continueAfterFailure = false
        
        // Set launch arguments
        app.launchArguments.append(TestingConstants.isTestArg) // -isTesting
        app.launchArguments.append(TestingConstants.mockedJsonArg) // -mockedJson
        
        // Generate new test data for every test case
        let testArticlesArray = ArticlesGenerator.generateData(numberOfArticles: Int.random(in: 1...50))
        
        // Set a specific headline for testing
        if let firstArticle = testArticlesArray.first {
            expectedArticleHeadline = firstArticle.headline
        }
        
        /* Pass json for test */
        // When using a json fixture instead of AppDataGenerator
        // let mockedJsonString = Utils.getJsonString(fileName: mockedJsonFilename, testCase: self)
        
        let mockedJsonString = ArticlesGenerator.createJsonString(articles: testArticlesArray) ?? ""
        app.launchArguments.append(mockedJsonString) // -mockedJson's parameter
        app.launch()
    }
    
    func testHeadline_RendersCorrectly() {
        let expectedHeadlineElement = app.cells.staticTexts.matching(NSPredicate(format: "label == '\(expectedArticleHeadline)' && identifier == '\(TestingConstants.headlineAccessibilityId)'")).element
        
        XCTAssert(expectedHeadlineElement.exists, "The headline doesn't properly render.")
    }
}
