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
        set {
            self.model.delegate = self
            self.model.product = newValue
        }
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
        
        self.controllerData = self.model.listData
        
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
}

extension ProductDetailsViewController: ViewDataModelRefreshProtocol {
    
    func modelDidRefresh(object: Any, error: Error?){
        
        if object is [Any] {
            performUpdates(nil)
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
        
        if let _ = object as? [Image]{
            return ProductImageSlideSectionController()
        }
        
        if let _ = object as? ProductDesc {
            return ProductOverviewController()
        }
        
        return PriceSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
