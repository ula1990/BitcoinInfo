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
    
   @objc public func changeColorForLabel(){
        if infoRateLabel.text!.range(of:"-") != nil {
            infoRateLabel.backgroundColor = UIColor(named: "NewRed")
        }else{
            infoRateLabel.backgroundColor = UIColor(named: "NewGreen")
        }
    }
    
    public func updateAdditionalInfo(coin: Coin){
        selectCoinLabel.isHidden = true
        infoPriceTitleLabel.text = "Price(USD):"
        percentDayTitleLabel.text = "24H Changes:"
        percentWeekTitleLabel.text = "7D Changes:"
        for value in coin.quotes.values {
            infoRateLabel.text = String((value.percent_change_1h)!)
            infoPriceLabel.text = String((value.price)!)
            percentDayLabel.text = String((value.percent_change_24h)!)
            percentWeekLabel.text = String((value.percent_change_7d)!)
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
    
    @objc public func handleMenu(){
        if (menuShowing){
            UIView.animate(withDuration: 0.3) {
                self.menuHeightAnchor?.isActive = false
                self.menuHeightAnchor = self.menuView.heightAnchor.constraint(equalToConstant: 0)
                self.menuHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.menuHeightAnchor?.isActive = false
                self.menuHeightAnchor = self.menuView.heightAnchor.constraint(equalToConstant: 150)
                self.menuHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (true) in
            }
        }
        menuShowing = !menuShowing
    }
    
    @objc public func handleNewsButton(){
        presentViewController(vc: NewsVC())
    }
    
    @objc public func presentViewController(vc: UIViewController){
        let newVC = UINavigationController(rootViewController: vc)
        present(newVC, animated: true, completion: nil)
    }
    
    
    @objc public func creatMenuArray() -> [Menu] {
        var array: [Menu] = []
        
        let item1 = Menu(name: "News", icon: "news", vc: NewsVC())
        let item2 = Menu(name: "About", icon: "about", vc: AboutVC())
        
        array.append(item1)
        array.append(item2)
        return array
    }
}
