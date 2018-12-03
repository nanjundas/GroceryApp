//
//  CatalogueViewModel.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift
import GroceryAppCore

class CatalogueViewModel: ViewDataModel {
    
    let realm = try! Realm()
    
    var listData = Array<Product>()
    
    override init() {
        
    }
    
    open override func populateData(cache: Bool ) {
        
        let products = realm.objects(Product.self)
        let token = products._observe { (notification) in
            
            switch notification {
            case .initial: break
            case .update(_, _, _, let modifications): do {
                
                var objs = [Product]()
                
                for index in modifications {
                    
                    if(index < self.listData.count) {
                        objs.append(self.listData[index])
                    }
                }
                
                if objs.count > 0 {
                    self.delegate?.modelDidRefresh(object: objs, error: nil)
                }
                }
            case .error( _): break
            }
        }
        
        if (self.token != nil) {
            self.token?.invalidate()
        }
        
        self.token = token
        self.listData.removeAll()
        self.listData.append(contentsOf: products)        
    }
    
    open override func refreshFeed(forceLoad: Bool = false, callback: @escaping (_ error: Error?) -> Void) -> Void {
        
        let query = DataManagerQuery()
        query.startPage = 0
        query.recordsPerPage = ViewDataModel.PageSize
        query.params["theme"] = "all-sales"
        DataManager.sharedInstance.catalogueSearch(query: query) { (result) in
            self.listData.removeAll()
            self.populateData(cache: false)
            callback(nil)
        }
    }
    
    open override func loadNextPage(callback: @escaping (Error?) -> Void) {
        
        let query = DataManagerQuery()
        query.startPage = self.listData.count/ViewDataModel.PageSize
        query.recordsPerPage = ViewDataModel.PageSize
        query.params["theme"] = "all-sales"
        
        DataManager.sharedInstance.catalogueSearch(query: query) { (result) in
            self.populateData(cache: false)
            callback(nil)
        }
    }
}
