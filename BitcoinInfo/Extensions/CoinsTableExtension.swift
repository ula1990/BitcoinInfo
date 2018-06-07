//
//  CoinsTableExtension.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = listOfCoins[indexPath.row]
        let cell = listOfCoinsTable.dequeueReusableCell(withIdentifier: coinCellId, for: indexPath ) as! CoinCell
        cell.updateDataInCell(coin: coin )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = listOfCoins[indexPath.row]
        updateAdditionalInfo(coin: coin)
        listOfCoinsTable.deselectRow(at: indexPath, animated: true)
        Alert.showBasic(title: "Info", msg: "Coin ID: \(String(coin.id!))" + " Coin Page: \(coin.website_slug!)", vc: self)
    }
}
