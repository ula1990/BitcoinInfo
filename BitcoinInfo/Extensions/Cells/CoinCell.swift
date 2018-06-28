//
//  CoinCell.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CoinCell: UITableViewCell {

    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "coin_logo")
        image.layer.cornerRadius = 15
        image.layer.shadowRadius = 2
        image.layer.shadowOpacity = 0.2
        return image
    }()
    
    lazy var coinRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    
    fileprivate func setupViews(){
        
        coinImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant:10).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        symbolLabel.leftAnchor.constraint(equalTo: coinImage.rightAnchor,constant: 10).isActive = true
        symbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        symbolLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        symbolLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: symbolLabel.rightAnchor,constant: 5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: coinRateLabel.leftAnchor,constant: -5).isActive = true
        
        coinRateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinRateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant:-10).isActive = true
        coinRateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        coinRateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(symbolLabel)
        addSubview(nameLabel)
        addSubview(coinImage)
        addSubview(coinRateLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func changeColorForLabel(){
        if coinRateLabel.text!.range(of:"-") != nil {
            coinRateLabel.backgroundColor = UIColor(named: "NewRed")
        }else{
            coinRateLabel.backgroundColor = UIColor(named: "NewGreen")
        }
    }
    
    func updateDataInCell(coin: Coin){
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        for value in coin.quotes.values {
            coinRateLabel.text = String((value.percent_change_1h)!)
        }
        changeColorForLabel()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
