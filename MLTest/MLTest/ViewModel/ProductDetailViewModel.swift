//
//  ProductDetailViewModel.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import Foundation

class ProductDetailViewModel: NSObject {
    private var coreService : CoreConnection!
    private var selectedProduct: String
    private(set) var productData : ResultProducts! {
        didSet {
            self.bindProductDetailViewModelToController()
        }
    }
    
    var bindProductDetailViewModelToController : (() -> ()) = {}
    
    init(selectedProduct: String) {
        self.selectedProduct = selectedProduct
        
        super.init()
        self.coreService =  CoreConnection()
        self.callFuncToGetProductData(selectedProduct: selectedProduct)
    }
    
    /**
        Funcion para hacer la busqueda con un limite configurable por la vista
     */
    func callFuncToGetProductData(selectedProduct: String) {
        self.coreService.getProduct(productId: selectedProduct) { productData in
            self.productData = productData.first
        }
    }
    
    func strCurrencyPrice() -> String {
        guard let tmpDataSource = self.productData else {
            return ""
        }
        let price = tmpDataSource.body?.price ?? 0
        let currency = tmpDataSource.body?.currencyId ?? ""
        
        return price.description.currencyFormatting(currency: currency)
    }
    
    func makeFullHtmlDescription() -> String {
        guard let tmpDataSource = self.productData else {
            return ""
        }
        
        var strAttributes: String = ""
        let attributes = tmpDataSource.body?.attributes
        
        attributes?.forEach({ attributesBodyResultProducts in
            let attrName = attributesBodyResultProducts.name ?? "", attrValueName = attributesBodyResultProducts.valueName ?? ""
            strAttributes += "<b>\(String(describing: attrName))</b>: \(String(describing: attrValueName)) <br/>"
//            print("attributesBodyResultProducts: \(attributesBodyResultProducts)")
        })
        
        return strAttributes
    }
}
