//
//  Article.swift
//  NewsReader
//
//  Created by Uladzislau Daratsiuk on 2018-04-17.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

struct NewsData: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
}

struct Article: Decodable {
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
}
