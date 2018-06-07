//
//  MainVCHandler.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC{
    @objc public func uploadBitcoinInfo(){
        listOfCoins.removeAll()
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "Offline Mode", msg: "Please check your connection to get last rates", vc: self)
                    self.offlineMode()
                }
                else{
                    self.onlineMode()
                    if data != nil{
                        self.infoLastUpdateDateLabel.text = self.todayDate()
                        do{
                            let json = try JSONDecoder().decode(BitCoinData.self, from: data!)
                            print(json.data)
                            for value in json.data{
                                self.listOfCoins.append(value.value)
                            }
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.listOfCoinsTable.reloadData()
            }
        }
        task.resume()
    }
    
    @objc public func todayDate() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = "Last update:" + dateFormatter.string(from: yesterday!)
        return date
    }
    
   public func changeColorForLabel(){
        if infoRateLabel.text!.range(of:"-") != nil {
            infoRateLabel.backgroundColor = UIColor(named: "NewRed")
            infoHintLabel.text = "It looks like your coin going down :("
        }else{
            infoRateLabel.backgroundColor = UIColor(named: "NewGreen")
            infoHintLabel.text = "Congrats!It looks like your coin going up :)"
        }
    }
    
    public func updateAdditionalInfo(coin: Coin){
        infoPriceTitleLabel.text = "Price:"
        for value in coin.quotes.values {
            infoRateLabel.text = String((value.percent_change_1h)!)
            infoPriceLabel.text = String((value.price)!)
        }
        changeColorForLabel()
    }
    
    @objc public func handleShare(){
        let activityVC = UIActivityViewController(activityItems: ["Take a look on amazing app."], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    public func offlineMode(){
            self.listOfCoinsTable.isHidden = true
            self.offlineLabel.isHidden = false
    }
    public func onlineMode(){
        self.listOfCoinsTable.isHidden = false
        self.offlineLabel.isHidden = true
    }
}
