//
//  PriceSectionController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 6/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import IGListKit
import RealmSwift
import GroceryAppCore

class PriceSectionController: ListSectionController {
    
    var product: Product?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: 85)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "PriceSectionCell", bundle: nil, for: self, at: index) as? PriceSectionCell ,
            let product = product else {
                fatalError()
        }

        cell.nameLabel.text = product.title
        cell.priceLabel.text = "$\(product.promoPrice == 0 ? product.price : product.promoPrice)"

        return cell
    }
    
    override func didUpdate(to object: Any) {
        product = object as? Product
    }
}
