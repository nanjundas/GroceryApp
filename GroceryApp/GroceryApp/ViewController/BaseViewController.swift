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
    
    func pullToRefresh(_ refreshControl: UIRefreshControl)
    func loadMore()
}

class BaseViewController: UIViewController {

}

class BaseListViewController: BaseViewController, ListViewControllerRefreshProtocol {

    open var recordsFound: RecordsFound = 0    
    open var listData: Array<Any> = []
    
    var isLoadMore = false
    var isLoading = false

    lazy var flowLayout:UICollectionViewFlowLayout = {
        
        let flow = UICollectionViewFlowLayout()
        flow.sectionHeadersPinToVisibleBounds = true
        
        return flow
    }()
    
    lazy var refreshCtl: UIRefreshControl = {
        
        let refresh = UIRefreshControl()
        refresh.contentScaleFactor = 0.5
        refresh.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        
        return refresh
    }()
    
    lazy var collectionView:UICollectionView = {
        
        let view =  UICollectionView(frame: .zero, collectionViewLayout:self.flowLayout)
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

        self.view.backgroundColor = UIColor(hex: 0xfaf9f9)
        self.view.addSubview(self.collectionView)

        self.collectionView.refreshControl = self.refreshCtl
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()

        self.collectionView.frame = self.view.bounds
        
        self.adapter.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    @objc open func pullToRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    open func loadMore() {}
}

extension BaseListViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        
        if self.recordsFound == self.listData.count {
            return
        }
        
        if (!isLoading && distance < 400){
            
            isLoadMore = true
            self.loadMore()
        }
    }
}
