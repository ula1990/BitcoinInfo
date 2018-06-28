//
//  AboutVC.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/28/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(handleBack))
        navigationController?.navigationBar.topItem?.title = "About"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .white
    }

}
