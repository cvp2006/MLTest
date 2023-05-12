//
//  Utils.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = loadedImage
                    }
                }
            }
        }.resume()
    }
}

extension String {
    // formatting text for currency textField
    func currencyFormatting(currency: String) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return "\(str) (\(currency))"
            }
        }
        return ""
    }
}

extension Int {
    func createCurrencyStringFormatting() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))!
    }
    
    func createDecimalStringFormatting() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))!
    }
}
