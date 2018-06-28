//
//  MelodieCollectionExt.swift
//  Sweet Dreams App
//
//  Created by Uladzislau Daratsiuk on 6/14/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let menu = menuList[indexPath.row]
            let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
            cell.updateCellData(menu: menu)
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            cell.layer.cornerRadius = 5
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let menu = menuList[indexPath.row]
            let vc = UINavigationController(rootViewController: menu.vc)
            present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

         return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 10)
    }
    
}
