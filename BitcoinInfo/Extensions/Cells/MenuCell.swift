//
//  MenuCell.swift
//  Sweet Dreams App
//
//  Created by Uladzislau Daratsiuk on 6/15/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let menuIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    
    let menuTitleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.text = "Text"
        return label
    }()
    
    func  setupView(){
        addSubview(menuIconImage)
        addSubview(menuTitleName)
        
        menuIconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        menuIconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menuIconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        menuIconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        menuTitleName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menuTitleName.topAnchor.constraint(equalTo: menuIconImage.bottomAnchor,constant: 2).isActive = true
        menuTitleName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menuTitleName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuTitleName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    func updateCellData(menu: Menu){
        menuTitleName.text = menu.name
        menuIconImage.image = UIImage(named: menu.icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
