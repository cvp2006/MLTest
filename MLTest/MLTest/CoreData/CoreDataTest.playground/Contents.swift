import UIKit

class TestCore {
    let coreConnection = CoreConnection()
    
    func testGetProductList(qSearch: String, offset: Int, limit: Int) {
        print( "Print qSearch: (\(qSearch)) - Detail: \(String(describing: qSearch))" )
        coreConnection.getProductList(qSearch: qSearch,offset: offset, limit: limit, completion: { searchData in
            print( "*** Init getListProduct ***" )
            print( "Print qSearch: (\(qSearch)) - Detail: \(String(describing: searchData))" )
//            print( "Print qSearch: (\(qSearch)) - Detail: \(String(describing: searchData.results[0].thumbnailId))" )
        })
    }
    
    func testGetDetailProduct(productId: String) {
        print( "Print productId: (\(productId))" )
        coreConnection.getProduct(productId: productId, completion: { resultProducts in
            print( "*** Init getListProduct ***" )
            print( "Print qSearch: (\(resultProducts))" )
        })
    }
}

//var greeting = "Hello, playground"

let testCore = TestCore()
var offset:Int = 900;
var limit:Int = 50;
testCore.testGetProductList(qSearch: "iphone", offset: offset, limit: limit)
testCore.testGetDetailProduct(productId: "MLA909924920")
//offset += limit
//testCore.testGetDetailPostInfoFromUrl(qSearch: "Iphone", offset: offset, limit: limit)
//offset += limit
//testCore.testGetDetailPostInfoFromUrl(qSearch: "Iphone", offset: offset, limit: limit)
