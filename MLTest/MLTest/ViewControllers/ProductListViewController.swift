//
//  ProductListViewController.swift
//  MLTest
//
//  Created by Carlos Velasquez on 23/04/23.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblFooterDetail: UILabel!
    @IBOutlet weak var loaderActivity: UIActivityIndicatorView!
    
    private var productViewModel : ProductViewModel!
    private var selectedIndexPath: IndexPath?
    private var dataSource : ProductTableViewDataSource<ProductTableViewCell, ItemSearchResults>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        productTableView.delegate = self
        productTableView.dataSource = self
        searchBar.delegate = self
        
        callToViewModelForUIUpdate()
    }

    private func callToViewModelForUIUpdate() {
        self.productViewModel =  ProductViewModel()
        self.productViewModel.bindProductViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource(){
        guard let tmpDataSource = self.productViewModel.productData else {
            return
        }
        
        self.dataSource = ProductTableViewDataSource(cellIdentifier: "ProductTableViewCell", items: tmpDataSource, configureCell: { (cell, productData) in
            cell.itemInfo = productData
        })
        
        self.dataSource.tableNumberOfRowsInSection { (numberRow) in
            self.lblFooterDetail.text = "# Filas: " + numberRow.createDecimalStringFormatting()
        }
        
        DispatchQueue.main.async {
            self.productTableView.dataSource = self.dataSource
            self.productTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails") {
            if let vc: ProductDetailsViewController = segue.destination as? ProductDetailsViewController {
                if let theSender = sender as? ProductListViewController {
                    guard let indexPath = theSender.selectedIndexPath?.row
                    else{
                        return
                    }
                    let product = self.productViewModel.productData[indexPath]
                    print("product.id: " + product.id)
                    vc.setProductId(theProductId: product.id )
                }
            }
        }
    }

}

// MARK: - extension
/**
 we extend the ProductListViewController class to listen to the calls of the UITableViewDataSource protocol
 and to be able to modify some characteristics of the table
 */
extension ProductListViewController: UITableViewDataSource {
    // MARK: - Delegate for extension UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fucionalidad usada en la clase datasource
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fucionalidad usada en la clase datasource
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension ProductListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let isReachingEnd = scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)

        if(isReachingEnd) {
            loaderActivity.startAnimating()
            productViewModel.callFuncGetMoreProductData {
                DispatchQueue.main.async {
                    self.loaderActivity.stopAnimating()
                }
            }
        }
    }
}

extension ProductListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText.isEmpty) {
            loaderActivity.startAnimating()
            productViewModel.callFuncToGetProductData(qSearch: "") {
                DispatchQueue.main.async {
                    self.loaderActivity.stopAnimating()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        if(!searchText.isEmpty){
            loaderActivity.startAnimating()
            productViewModel.callFuncToGetProductData(qSearch: searchText){
                DispatchQueue.main.async {
                    self.loaderActivity.stopAnimating()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
}
