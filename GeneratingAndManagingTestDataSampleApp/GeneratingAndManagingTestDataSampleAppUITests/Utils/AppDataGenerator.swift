//
//  AppDataGenerator.swift
//  GeneratingAndManagingTestDataSampleAppUITests
//
//  Created by Omose Ogala on 11/3/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import Foundation
import Fakery

class AppDataGenerator {

    static func generateData(numberOfArticles: Int) -> [Article] {
        var articles = [Article]()
        
        for _ in 0..<numberOfArticles {
            // Fakery - https://github.com/vadymmarkov/Fakery
            let faker = Faker(locale: "en-US")
            
            let article = Article.init(date: faker.number.randomInt(min: 0, max:Int(Date().timeIntervalSince1970)),
                                       link: faker.internet.url(),
                                       photoLink: faker.internet.image(),
                                       headline: faker.lorem.words(amount: 8),
                                       author: faker.name.name(),
                                       fullText: faker.lorem.sentences(amount: 6))
            articles.append(article)
        }
        
        return articles
    }
    
    static func createJsonString(articles: [Article]) -> String? {
        let jsonStructure = "{\"articles\":%@}"
        
        do {
            let jsonData = try JSONEncoder().encode(articles)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return String(format: jsonStructure, jsonString)
        } catch {
            return nil
        }
    }
}
