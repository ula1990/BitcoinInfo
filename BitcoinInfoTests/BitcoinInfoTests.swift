//
//  BitcoinInfoTests.swift
//  BitcoinInfoTests
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import XCTest
@testable import BitcoinInfo

class BitcoinInfoTests: XCTestCase {
    
    func testUrl(){
        let receivedUrl: String?
        receivedUrl = MainVC().urlString
        XCTAssertEqual(receivedUrl, "https://api.coinmarketcap.com/v2/ticker/")
    }
 
}
