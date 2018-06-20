//
//  MainVC.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let mainTextSize: CGFloat = 12
    let coinCellId = "coinCellId"
    var listOfCoins: [Coin] = []
    let urlString = "https://api.coinmarketcap.com/v2/ticker/"

    lazy var additionalInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "Additional info:"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoLastUpdateDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "Last update: unknown:"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 20
        label.layer.shadowOpacity = 0.2
        label.layer.shadowRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    lazy var infoPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentDayTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentWeekTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentWeekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoHintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var offlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "Check connection and press Refresh"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "List of the coins:"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.clipsToBounds = true
        return label
    }()
    
    lazy var listOfCoinsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CoinCell.self, forCellReuseIdentifier: coinCellId)
        table.backgroundColor = .white
        return table
    }()

    fileprivate func setupView(){
        additionalInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        additionalInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        additionalInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        additionalInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        additionalInfoView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        infoTitleLabel.topAnchor.constraint(equalTo: additionalInfoView.topAnchor, constant: 10).isActive = true
        infoTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        infoTitleLabel.rightAnchor.constraint(equalTo: additionalInfoView.centerXAnchor).isActive = true
        infoTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        infoLastUpdateDateLabel.topAnchor.constraint(equalTo: additionalInfoView.topAnchor, constant: 10).isActive = true
        infoLastUpdateDateLabel.rightAnchor.constraint(equalTo: additionalInfoView.rightAnchor, constant: -10).isActive = true
        infoLastUpdateDateLabel.leftAnchor.constraint(equalTo: additionalInfoView.centerXAnchor).isActive = true
        infoLastUpdateDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        infoRateLabel.centerYAnchor.constraint(equalTo: additionalInfoView.centerYAnchor).isActive = true
        infoRateLabel.rightAnchor.constraint(equalTo: additionalInfoView.rightAnchor, constant: -20).isActive = true
        infoRateLabel.heightAnchor.constraint(equalToConstant: 110).isActive = true
        infoRateLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        infoPriceTitleLabel.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor,constant: 10).isActive = true
        infoPriceTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        infoPriceTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoPriceTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        infoPriceLabel.topAnchor.constraint(equalTo: infoPriceTitleLabel.bottomAnchor).isActive = true
        infoPriceLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        infoPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoPriceLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentDayTitleLabel.topAnchor.constraint(equalTo: infoPriceLabel.bottomAnchor).isActive = true
        percentDayTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        percentDayTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentDayTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentDayLabel.topAnchor.constraint(equalTo: percentDayTitleLabel.bottomAnchor).isActive = true
        percentDayLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        percentDayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentDayLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentWeekTitleLabel.topAnchor.constraint(equalTo: percentDayLabel.bottomAnchor).isActive = true
        percentWeekTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        percentWeekTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentWeekTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentWeekLabel.topAnchor.constraint(equalTo: percentWeekTitleLabel.bottomAnchor).isActive = true
        percentWeekLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        percentWeekLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentWeekLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true

        infoHintLabel.bottomAnchor.constraint(equalTo: additionalInfoView.bottomAnchor, constant: -10).isActive = true
        infoHintLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        infoHintLabel.rightAnchor.constraint(equalTo: additionalInfoView.rightAnchor).isActive = true
        infoHintLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: additionalInfoView.bottomAnchor, constant: 20).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        listOfCoinsTable.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        listOfCoinsTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        listOfCoinsTable.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        listOfCoinsTable.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        listOfCoinsTable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -20).isActive = true
        
        offlineLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        offlineLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        offlineLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.topItem?.title = "Bitcoin Info"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"update"), style: .plain, target: self, action: #selector(uploadBitcoinInfo))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
    }
    
    fileprivate func addElements() {
        view.addSubview(mainView)
        view.addSubview(additionalInfoView)
        additionalInfoView.addSubview(infoTitleLabel)
        additionalInfoView.addSubview(infoLastUpdateDateLabel)
        additionalInfoView.addSubview(infoRateLabel)
        additionalInfoView.addSubview(infoPriceLabel)
        additionalInfoView.addSubview(infoPriceTitleLabel)
        additionalInfoView.addSubview(infoHintLabel)
        additionalInfoView.addSubview(percentDayTitleLabel)
        additionalInfoView.addSubview(percentDayLabel)
        additionalInfoView.addSubview(percentWeekTitleLabel)
        additionalInfoView.addSubview(percentWeekLabel)
        mainView.addSubview(titleLabel)
        mainView.addSubview(listOfCoinsTable)
        mainView.addSubview(offlineLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addElements()
        setupView()
        setupNavBar()
        listOfCoinsTable.delegate = self
        listOfCoinsTable.dataSource = self
        self.uploadBitcoinInfo()
    }
}
