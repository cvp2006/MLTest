//
//  ProductDetailsViewController.swift
//  MLTest
//
//  Created by Carlos Velasquez on 23/04/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var descriptionProduct: UITextView!
    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderImgPageControle: UIPageControl!
    @IBOutlet weak var lblPrice: UILabel!
    
    private var dataSource : ProductCollectionViewDataSource<SliderCollectionViewCell, PicturesBodyResultProducts>!
    private var productDetailViewModel : ProductDetailViewModel!
    private var productId: String?
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sliderImgPageControle.numberOfPages = 0
        sliderImgPageControle.currentPage = 0
        imageSliderCollectionView.delegate = self
//        imageSliderCollectionView.dataSource = self
        callToViewModelForUIUpdate()
    }

    func setProductId (theProductId: String) {
        self.productId = theProductId
    }
    
    private func callToViewModelForUIUpdate() {
        guard let tmpSelectedProduct = self.productId else {
            return
        }
        
        self.productDetailViewModel =  ProductDetailViewModel( selectedProduct: tmpSelectedProduct)
        self.productDetailViewModel.bindProductDetailViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource(){
        guard let tmpDataSource = self.productDetailViewModel.productData else {
            return
        }
        
        let pictureItems: [PicturesBodyResultProducts] = tmpDataSource.body?.pictures ?? []
        self.dataSource = ProductCollectionViewDataSource(cellIdentifier: "imgSliderCell", items: pictureItems, configureCell: { (cell, productData) in
            cell.itemInfo = productData
        })
        
        DispatchQueue.main.async {
            self.titleProduct.text = tmpDataSource.body?.title
            let productCurrencyPrice = self.productDetailViewModel.strCurrencyPrice()
            self.lblPrice.text = productCurrencyPrice
            let productHtmlDesc = self.productDetailViewModel.makeFullHtmlDescription()
            self.descriptionProduct.setHTMLFromString( htmlText: productHtmlDesc )
            self.sliderImgPageControle.numberOfPages = tmpDataSource.body?.pictures?.count ?? 0
            self.sliderImgPageControle.currentPage = 0
            self.imageSliderCollectionView.dataSource = self.dataSource
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        sliderImgPageControle.currentPage = Int(pageNumber)
    }
}

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<div style=\"font-family: 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</div>", htmlText)

        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .utf8, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


