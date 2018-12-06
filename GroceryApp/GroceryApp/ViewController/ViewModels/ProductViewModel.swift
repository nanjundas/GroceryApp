//
//  ProductViewModel.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 4/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift
import GroceryAppCore

typealias ProductDesc = String

class ProductViewModel: ViewDataModel {
    
    let realm = try! Realm()
    
    var listData = Array<Any>()

    var product: Product? {
        
        didSet {
         
            guard let product = product else { return }
            
            let token = product.observe { (notification) in
                
                switch notification {
                case .deleted: break
                case .error(_): break
                case .change(_):
                    self.delegate?.modelDidRefresh(object: self.product!, error: nil) // TODO - future
                }
            }
            
            self.token = token
            
            self.populateData()
        }
    }
    
    open override func populateData(cache: Bool = false) {

        listData.removeAll()
        
        if let images = product?.images {
            listData.append(Array(images))
        }
        
        if let product = product {
            listData.append(product)
        }
        
        if let desc = product?.desc {
            listData.append(desc)
        }
        
        self.delegate?.modelDidRefresh(object: listData, error: nil)
    }
}
