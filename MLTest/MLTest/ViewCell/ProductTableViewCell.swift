//
//  ProductTableViewCell.swift
//  MLTest
//
//  Created by Carlos Velasquez on 24/04/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var itemInfo : ItemSearchResults? {
        didSet {
            // let itemId = itemInfo?.id,
            guard let itemTitle = itemInfo?.title, let currency = itemInfo?.currencyId, var itemPrice: String = itemInfo?.price.description
            else{
                return
            }
            
            itemPrice = itemPrice.currencyFormatting(currency: currency)
            let thumbnailUrl = itemInfo?.thumbnail ?? ""
            let http: URL? = URL(string: thumbnailUrl)
            if let http = http {
                var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
                comps.scheme = "https"
                let secureUrl = comps.url?.absoluteString ?? ""
                imgProduct.loadFrom(URLAddress: secureUrl)
            }
            
            productTitleLabel.text = "\(String(describing: itemTitle))"
            productPriceLabel.text = itemPrice
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

