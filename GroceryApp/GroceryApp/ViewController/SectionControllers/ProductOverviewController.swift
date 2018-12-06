//
//  ProdcutOverviewController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 6/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import GroceryAppCore

class ProductOverviewController: ListSectionController {
    
    var overviewText:String = ""
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        let text = overviewText as NSString
        
        let width = collectionContext!.containerSize.width
        let size = text.size(withAttributes: [NSAttributedString.Key.font: ProductOverviewCell.font])
        
        return CGSize(width: width, height: ceil(size.width/(width - 18)) * ceil(size.height) + 20)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext?.dequeueReusableCell(of: ProductOverviewCell.self,
                                                          for: self,
                                                          at: index) as? ProductOverviewCell
        cell?.overviewText = overviewText
        
        return cell!
    }
    
    override func didUpdate(to object: Any) {
        overviewText = object as! String
    }
}
