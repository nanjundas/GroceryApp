//
//  LoadMoreSectionController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 3/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

internal class SpinnerCell:UICollectionViewCell {
    
    lazy var spinner:UIActivityIndicatorView = {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.color = .darkGray
        spinner.contentScaleFactor = 0.7
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
        self.addSubview(spinner)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.spinner.center = self.contentView.center
    }
}

public final class ListSpinnerSectionController: ListSectionController{
    
    public override init() {
        super.init()
        displayDelegate = self
    }
    
    override public func numberOfItems() -> Int {
        return 1
    }
    
    override public func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: (collectionContext!.containerSize.width - (inset.left + inset.right)), height: 50)
    }
    
    override public func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: SpinnerCell.self, for: self, at: index) as? SpinnerCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = self.viewController?.view.backgroundColor
        
        return cell
    }
}


extension ListSpinnerSectionController: ListDisplayDelegate {
    
    public func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {
        
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {
        
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
        if let cell = cell as? SpinnerCell {
            cell.spinner.startAnimating()
        }
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
        if let cell = cell as? SpinnerCell {
            cell.spinner.stopAnimating()
        }
    }
}


