//
//  MenuModel.swift
//  Sweet Dreams App
//
//  Created by Uladzislau Daratsiuk on 6/15/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Menu: NSObject {
    let name: String
    let icon: String
    let vc: UIViewController
    
    init(name: String,icon: String, vc: UIViewController){
        self.name = name
        self.icon = icon
        self.vc = vc
        
    }
}
