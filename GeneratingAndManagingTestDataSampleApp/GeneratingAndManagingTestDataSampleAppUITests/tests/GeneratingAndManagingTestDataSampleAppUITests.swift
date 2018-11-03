//
//  GeneratingAndManagingTestDataSampleAppUITests.swift
//  GeneratingAndManagingTestDataSampleAppUITests
//
//  Created by Omose Ogala on 11/1/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import XCTest

class GeneratingAndManagingTestDataSampleAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        
        // Set launch arguments
        app.launchArguments.append(TestingArgumentNames.isTestArg)
        app.launchArguments.append(TestingArgumentNames.mockedJsonArg)
        
        // Pass json for test
        let mockedJsonString = Utils.getJsonString(fileName: "mockedNewsArticles.json", testCase: self)
        app.launchArguments.append(mockedJsonString)

        app.launch()
    }

    func testTitleShows() {
        sleep(1000)
    }

}
