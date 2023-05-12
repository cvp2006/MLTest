//
//  ProductTableViewDataSource.swift
//  MLTest
//
//  Created by Carlos Velasquez on 24/04/23.
//

import Foundation
import UIKit

class ProductTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UIScrollViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var funcNumberOfRowsInSection : (Int) -> () = {_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableNumberOfRowsInSection ( numberOfRowsInSection: @escaping (Int) -> ()) {
        self.funcNumberOfRowsInSection = numberOfRowsInSection
    }
    
    // MARK: - Delegate for extension UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.funcNumberOfRowsInSection(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)

        return cell
    }
}
