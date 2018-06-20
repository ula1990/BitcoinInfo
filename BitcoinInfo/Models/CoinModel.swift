//
//  CoinModel.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

struct BitCoinData: Decodable {
    let data: [String:Coin]
    }

struct Coin: Decodable {
    let id: Int?
    let name: String?
    let symbol: String?
    let total_supply: Int?
    let website_slug: String?
    let quotes: [String:USD]
}

struct USD: Decodable {
    let price: Double?
    let percent_change_1h: Double?
    let percent_change_24h: Double?
    let percent_change_7d: Double?
}
