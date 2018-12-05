//
//  ProductDetailsViewController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 4/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
import GroceryAppCore

class ProductDetailsViewController: BaseViewController {
    
    let model: ProductViewModel = ProductViewModel()
 
    var product: Product? {
        get {return self.model.product}
        set {self.model.product = newValue}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        self.adapter.dataSource = self
        
        populateData()
        refreshFeed()
        performUpdates(nil)
    }
}

extension ProductDetailsViewController {
    
    func performUpdates(_ error: Error?) {
        
        self.refreshCtl.endRefreshing()
        
        self.listData = self.model.listData
        self.isLoadMore = false
        
        self.updateSectionData(error)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func populateData(cache: Bool = true) {
        self.model.populateData(cache: cache)
    }
    
    func refreshFeed(forceLoad: Bool = false) {
        
        self.model.refreshFeed { (error) in
            self.performUpdates(error)
        }
    }
    
    func loadNextPage() {
        
        self.model.loadNextPage { (error) in
            self.performUpdates(error)
        }
    }
}

extension ProductDetailsViewController: ViewDataModelRefreshProtocol {
    
    func modelDidRefresh(object: Any, error: Error?){
        
        if let products = object as? [Product] {
            self.adapter.reloadObjects(products)
        }
    }
}

extension ProductDetailsViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.controllerData as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if let section = self.sectionControllerFor(object: object) {
            return section
        }
        
        return ProductsSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
