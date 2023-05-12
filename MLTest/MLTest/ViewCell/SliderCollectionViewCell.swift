//
//  CollectionViewCell.swift
//  MLTest
//
//  Created by Carlos Velasquez on 3/05/23.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    var itemInfo: PicturesBodyResultProducts! {
        didSet {
            guard let secureUrl = itemInfo?.secureUrl
            else{
                return
            }
            
            self.productImage.loadFrom(URLAddress: secureUrl)
            self.productImage.contentMode = .scaleAspectFit
        }
    }
    
}
