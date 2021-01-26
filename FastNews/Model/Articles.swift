//
//  Articles.swift
//  FastNews
//
//  Created by Максим Солнцев on 11/10/20.
//

import Foundation

public struct Article: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

public struct ArticlesResponse: Decodable {
    enum Status: String, Decodable {
        case ok
        case error
    }
    let status: Status
    let articles: [Article]
    let message: String?
}
