//
//  ProductCollectionViewDataSource.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import UIKit

class ProductCollectionViewDataSource<CELL : UICollectionViewCell,T> : NSObject, UICollectionViewDataSource, UIScrollViewDelegate {
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var funcNumberOfRowsInSection : (Int) -> () = {_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SliderCollectionViewCell
        
        guard let productImgs = items else {
            return cell
        }
        cell.itemInfo = productImgs[indexPath.row] as? PicturesBodyResultProducts
        
        return cell
    }
    
}
