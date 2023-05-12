//
//  CoreConnection.swift
//  MLTest
//
//  Created by Carlos Velasquez on 23/04/23.
//

import Foundation

public class CoreConnection {
    private var urlConnection : String?
    private var params: [String: String]?
    private var nameMethod: String = "GET"
    private var siteId: String = "MLA"
    
    public func setUrlConnection (newUrlConnection: String) {
        urlConnection = newUrlConnection
    }
    
    public func getUrlConnection () -> String {
        return urlConnection!
    }
    
    private func runConnection(completion : @escaping (Data) -> ()) {
        guard let theUrlConnection = urlConnection
        else{
            return;
        }
        guard let objURL = URL(string: theUrlConnection.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") //URL(string: theUrlConnection)
        else{
            return;
        }
        
        
        var request = URLRequest(url: objURL)
        request.httpMethod = nameMethod

        if(params != nil) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("token", forHTTPHeaderField: "Authorization")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params!)
            } catch {
                print(error)
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error != nil {
                print( "Found error when execute \(String(describing: error))" )
            } else {
                if let data = data {
                    completion(data)
                }
            }
        }.resume()
    }
    
    func getProductList(qSearch: String, offset: Int, limit: Int, completion : @escaping (SearchData) -> ()) {
        self.urlConnection = "https://api.mercadolibre.com/sites/\(siteId)/search?q=\(qSearch)&offset=\(offset)&limit=\(limit)";
        
        self.runConnection { (data) in
            let jsonDecoder = JSONDecoder()
            let objJson = try! jsonDecoder.decode(SearchData.self, from: data)
            completion(objJson)

        }
    }
    
    func getProduct(productId: String, completion : @escaping ([ResultProducts]) -> ()) {
        self.urlConnection = "https://api.mercadolibre.com/items?ids=\(productId)";
        
        self.runConnection { (data) in
            let jsonDecoder = JSONDecoder()
            let objJson = try! jsonDecoder.decode([ResultProducts].self, from: data)
            completion(objJson)

        }
    }
}
