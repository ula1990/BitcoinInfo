//
//  NewsVCHandler.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC {
    @objc public func getDataNews(token: String?){
        let url = URL(string: newsUrl + token!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK OF PICKERVIEW
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "Offline Mode", msg: "Please check connection and update the rates,in offline mode available only EUR", vc: self)
                    self.titleLabel.text = "Last update: Unknown"
                }
                else{
                    self.news.removeAll()
                    self.newsOffline.removeAll()
                    if data != nil{
                        self.titleLabel.text = self.todayDate()
                        do {
                            let json = try JSONDecoder().decode(NewsData.self, from: data!)
                            for value in json.articles{
                                self.news.append(value)
                                self.newsOffline.append(value)
                                print(value)
                            }
                            
                            
                        }
                        catch{
                            print(Error.self)
                        }
                    }
                }
                self.newsTable.reloadData()
            }
        }
        task.resume()
    }
    
    @objc public func handleUpdate(){
        self.getDataNews(token: token)
    }
    
    @objc public func handleBack(){
        let vc = UINavigationController(rootViewController: MainVC())
        present(vc, animated: true, completion: nil)
    }
    
    @objc public func todayDate() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = "Last update:" + dateFormatter.string(from: yesterday!)
        return date
    }

}
