//
//  ProductViewModel.swift
//  MLTest
//
//  Created by Carlos Velasquez on 24/04/23.
//

import Foundation

class ProductViewModel: NSObject {
    private var isSearching: Bool = false
    private var isMoreSearching: Bool = false
    private var currentQSearch = ""
    private var currentOffset = 0
    private var currentLimit = 50
    private var isFilterData : Bool = false
    private var coreService : CoreConnection!
    private(set) var productData : Results! {
        didSet {
            self.bindProductViewModelToController()
        }
    }
    
    var bindProductViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.coreService =  CoreConnection()
    }
    
    /**
        Funcion para hacer la busqueda con un limite por defecto
     */
    func callFuncToGetProductData(qSearch: String, completion : @escaping () -> ()) {
        let offset = 0, limit = currentLimit
        self.callFuncToGetProductData(qSearch: qSearch, offset: offset, limit: limit) {
            completion()
        }
    }
    
    /**
        Funcion para hacer la busqueda con un limite configurable por la vista
     */
    func callFuncToGetProductData(qSearch: String, offset: Int, limit: Int, completion : @escaping () -> ()) {
        isSearching = true;
        if(offset==0){
            self.isMoreSearching = false
        }
        currentOffset = offset
        currentQSearch = qSearch
        self.coreService.getProductList(qSearch: qSearch, offset: offset, limit: limit) { searchData in
            self.isSearching = false;
            guard let tmpResults = searchData.results else {
                return
            }
            if(self.isMoreSearching){
                if(self.productData != nil) {
                    let flattenCollection = [self.productData, tmpResults].joined()
                    
                    self.productData = Array(flattenCollection)
                }else {
                    self.productData = tmpResults
                }
            }else{
                self.productData = tmpResults
            }
            
            completion();
        }
    }
    
    /**
        Funcion para aumentar el offset y buscar mas productos en la paginacion automatica.
     */
    func callFuncGetMoreProductData(completion : @escaping () -> ()) {
        if(!self.isSearching) {
            self.isMoreSearching = true
            currentOffset+=currentLimit
            callFuncToGetProductData(qSearch: currentQSearch, offset: currentOffset, limit: currentLimit) {
                completion()
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return productData.count
    }
}
