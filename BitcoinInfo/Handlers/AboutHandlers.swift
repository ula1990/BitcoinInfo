//
//  AboutHandlers.swift
//  BitcoinInfo
//
//  Created by Uladzislau Daratsiuk on 6/28/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension AboutVC {
    @objc public func handleBack(){
        let vc = UINavigationController(rootViewController: MainVC())
        present(vc, animated: true, completion: nil)
    }
}
