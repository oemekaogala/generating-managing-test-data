//
//  Article.swift
//  GeneratingAndManagingTestDataSampleApp
//
//  Created by Omose Ogala on 11/3/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import Foundation

struct Article: Codable {
    var date: Int
    var link: String
    var photoLink: String
    var headline, author, fullText: String
}
