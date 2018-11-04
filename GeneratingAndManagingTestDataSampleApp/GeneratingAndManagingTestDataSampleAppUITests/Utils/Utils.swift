//
//  Utils.swift
//  GeneratingAndManagingTestDataSampleAppUITests
//
//  Created by Omose Ogala on 11/2/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import Foundation
import XCTest

class Utils {
    static func getJsonString(fileName: String, testCase: XCTestCase) -> String {
        let fileNameArray = fileName.split(separator: ".")
        
        guard
            fileNameArray.count == 2,
            let resourceName = fileNameArray.first,
            let extensionType = fileNameArray.last
            else {
                fatalError("Your file name \"\(fileName)\" is incorrect.")
        }
        
        let testBundle = Bundle(for: type(of: testCase))
        let path = testBundle.path(forResource: String(resourceName), ofType: String(extensionType))
        
        do {
            var template = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            template = template.replacingOccurrences(of: "\n", with: "")
            template = template.replacingOccurrences(of: "\'", with: "")
            return template
        } catch {
            fatalError("Your file \"\(fileName)\" does not exist in test bundle.")
        }
    }
}
