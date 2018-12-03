//
//  ViewController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
import GroceryAppCore

class CatalogueViewController: BaseViewController {
    
    let model = CatalogueViewModel()
    
    override func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        refreshFeed(forceLoad: true)
    }
    
    override func loadMore() {
        isLoadMore = true
        loadNextPage()
        self.updateSectionData(nil)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshCtl.beginRefreshing()
        self.collectionView.setContentOffset(CGPoint(x:0, y:-60) , animated: false)
        self.model.delegate = self
        self.adapter.dataSource = self
        
        populateData()
        refreshFeed()
        performUpdates(nil)
    }
}

extension CatalogueViewController {
    
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

extension CatalogueViewController: ViewDataModelRefreshProtocol {
    
    func modelDidRefresh(object: Any, error: Error?){
        
        if let products = object as? [Product] {
            self.adapter.reloadObjects(products)
        }
    }
}

extension CatalogueViewController: ListAdapterDataSource {
    
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
