//
//  NewsCell.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 3
        return label
    }()
    
    lazy var newsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 5
        return label
    }()
    
    
    lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        return image
    }()
    
    func updateData(title: String?, description: String? , imageUrl: String?, pubDate: String?){
        newsTitle.text = title
        newsDescription.text = description
        if imageUrl == nil {
            self.newsImage.image = UIImage(named: "not_found")
        }else{
        do{
            let url = URL(string: imageUrl!)
            let data = try Data(contentsOf: url!)
            self.newsImage.image = UIImage(data: data)
        }catch{
            print(error)
        }
        }
    }
    
    fileprivate func addViews() {
        addSubview(newsTitle)
        addSubview(newsDescription)
        addSubview(newsImage)
        setupCellView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    func setupCellView(){
        
        newsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        newsImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        newsImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        newsTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        newsTitle.leftAnchor.constraint(equalTo: newsImage.rightAnchor, constant: 10).isActive = true
        newsTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        newsTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 1).isActive = true
        newsDescription.leftAnchor.constraint(equalTo: newsImage.rightAnchor, constant: 10).isActive = true
        newsDescription.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -5).isActive = true
        newsDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

