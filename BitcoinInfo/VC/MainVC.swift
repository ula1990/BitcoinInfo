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
    let titleTextSize: CGFloat = 17
    let coinCellId = "coinCellId"
    var listOfCoins: [Coin] = []
    let urlString = "https://api.coinmarketcap.com/v2/ticker/"
    var menuShowing = false
    var menuHeightAnchor: NSLayoutConstraint?
    var mainTextColor = UIColor.black.withAlphaComponent(0.7)
    var menuList: [Menu] = []
    let menuCellId = "menuCellId"
    
    lazy var additionalInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var selectCoinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = mainTextColor
        label.text = "Please select Coin"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.clipsToBounds = true
        label.isHidden = false
        return label
    }()
    
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = mainTextColor
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
        label.textColor = mainTextColor
        label.text = "Last update: Unknown"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: titleTextSize)
        label.textColor = mainTextColor
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
        label.layer.shadowOpacity = 0.3
        label.layer.shadowRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var infoPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentDayTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: titleTextSize)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentWeekTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: titleTextSize)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var percentWeekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var infoHintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: mainTextSize)
        label.textColor = mainTextColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var offlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = mainTextColor
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
        label.textColor = mainTextColor
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
        table.backgroundColor = UIColor.black.withAlphaComponent(0)
        return table
    }()
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Menu"
        return label
    }()
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 1, bottom: 1, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.isScrollEnabled = true
        return view
    }()
    

    fileprivate func setupView(){
        
        additionalInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        additionalInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        additionalInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        additionalInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        additionalInfoView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        selectCoinLabel.centerXAnchor.constraint(equalTo: additionalInfoView.centerXAnchor).isActive = true
        selectCoinLabel.centerYAnchor.constraint(equalTo: additionalInfoView.centerYAnchor).isActive = true
        selectCoinLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectCoinLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 20).isActive = true
        selectCoinLabel.rightAnchor.constraint(equalTo: additionalInfoView.rightAnchor, constant: -20).isActive = true
        
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
        
        infoPriceTitleLabel.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor).isActive = true
        infoPriceTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        infoPriceTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoPriceTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        infoPriceLabel.topAnchor.constraint(equalTo: infoPriceTitleLabel.bottomAnchor).isActive = true
        infoPriceLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        infoPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoPriceLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentDayTitleLabel.topAnchor.constraint(equalTo: infoPriceLabel.bottomAnchor).isActive = true
        percentDayTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        percentDayTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentDayTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentDayLabel.topAnchor.constraint(equalTo: percentDayTitleLabel.bottomAnchor).isActive = true
        percentDayLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        percentDayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentDayLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentWeekTitleLabel.topAnchor.constraint(equalTo: percentDayLabel.bottomAnchor).isActive = true
        percentWeekTitleLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
        percentWeekTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentWeekTitleLabel.rightAnchor.constraint(equalTo: infoRateLabel.leftAnchor, constant: -10).isActive = true
        
        percentWeekLabel.topAnchor.constraint(equalTo: percentWeekTitleLabel.bottomAnchor).isActive = true
        percentWeekLabel.leftAnchor.constraint(equalTo: additionalInfoView.leftAnchor, constant: 10).isActive = true
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
        listOfCoinsTable.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        listOfCoinsTable.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        listOfCoinsTable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -20).isActive = true
        
        offlineLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        offlineLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        offlineLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        menuView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: 0)
        menuHeightAnchor?.isActive = true
        
        menuTitleLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor).isActive = true
        menuTitleLabel.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 10).isActive = true
        menuTitleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        menuTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        menuCollectionView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor).isActive = true
        menuCollectionView.topAnchor.constraint(equalTo: menuTitleLabel.bottomAnchor, constant: 5).isActive = true
        menuCollectionView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        menuCollectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.topItem?.title = "Bitcoin Info"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"update"), style: .plain, target: self, action: #selector(uploadBitcoinInfo))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    fileprivate func addElements() {
        view.addSubview(mainView)
        view.addSubview(additionalInfoView)
        additionalInfoView.addSubview(infoTitleLabel)
        additionalInfoView.addSubview(selectCoinLabel)
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
        view.addSubview(menuView)
        menuView.addSubview(menuTitleLabel)
        menuView.addSubview(menuCollectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addElements()
        setupView()
        setupNavBar()
        listOfCoinsTable.delegate = self
        listOfCoinsTable.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        self.uploadBitcoinInfo()
        menuList = creatMenuArray()
    }
}
