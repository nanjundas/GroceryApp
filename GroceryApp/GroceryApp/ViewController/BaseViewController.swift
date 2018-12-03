//
//  BaseViewController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import UIKit
import RealmSwift
import IGListKit

protocol ListViewControllerRefreshProtocol {
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl)
    func loadMore()
}

class BaseViewController: UIViewController, ListViewControllerRefreshProtocol {

    typealias LoadMore = Bool
    
    open var listData: Array<Any> = []
    
    var controllerData: Array<Any> = []

    var isLoadMore: LoadMore = false
    var isLoading = false
    
    lazy var refreshCtl: UIRefreshControl = {
        
        let refresh = UIRefreshControl()
        refresh.contentScaleFactor = 0.5
        refresh.addTarget(self, action: #selector(self.didPullToRefresh(_:)), for: .valueChanged)
        
        return refresh
    }()
    
    lazy var collectionView:UICollectionView = {
        
        let view =  UICollectionView(frame: .zero, collectionViewLayout:ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
        view.backgroundColor = self.view.backgroundColor
        
        return view
    } ()
    
    lazy var adapter: ListAdapter = {
        
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        adapter.scrollViewDelegate = self

        return adapter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xe9e9e9)
        self.view.addSubview(self.collectionView)
        
        self.collectionView.backgroundColor = UIColor(hex: 0xe9e9e9)
        self.collectionView.refreshControl = self.refreshCtl
        
        adapter.collectionView = collectionView        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = self.view.bounds.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        self.adapter.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    @objc open func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    func loadMore() {
        
    }

    func updateSectionData(_ error: Error?) {
        
        self.controllerData.removeAll()
        
        self.controllerData.append(self.listData)
        
        if(isLoadMore) {
            self.controllerData.append(self.isLoadMore)
        }
    }
    
    func sectionControllerFor(object: Any) -> ListSectionController? {
        
        if object is LoadMore {
            return ListSpinnerSectionController()
        }
        
        return nil
    }
}

extension BaseViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
                
        if (!isLoading && distance < 400){
            
            isLoadMore = true
            self.loadMore()
        }
    }
}
