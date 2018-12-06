//
//  ProductsSectionController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import IGListKit
import RealmSwift
import GroceryAppCore

class ProductsSectionController: ListSectionController {
    
    var items = Array<Product>()
    
    override init() {
        super.init()
        displayDelegate = self

        inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
    }
    
    override func numberOfItems() -> Int {
        return self.items.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        let width = collectionContext?.containerSize.width ?? 0
        let totalSpace = width - (minimumInteritemSpacing)
        let itemSize = floor(totalSpace / 2) - 16
        return CGSize(width: itemSize, height: itemSize * 1.5)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ProductCell", bundle: nil, for: self, at: index) as? ProductCell else {
            fatalError()
        }
    
        let product = items[index]
        
        cell.priceLabel.text = "$\(product.promoPrice == 0 ? product.price : product.promoPrice)"
        cell.nameLabel.text = product.title
        cell.thumbImageView.image = product.cachedThumbnailImage()
        
        if (product.promoPrice > 0) {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$\(product.price)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.subTextLabel.attributedText = attributeString
        }
        else {
            cell.subTextLabel.text = ""
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        
        items.removeAll()
        
        if let products = object as? [Product] {
            
            for obj in products {
                self.items.append(obj)
            }
        }
    }
    
    override func didSelectItem(at index: Int) {
        
        let vc = ProductDetailsViewController()
        vc.product = self.items[index]
        
        UISelectionFeedbackGenerator().selectionChanged()
        
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProductsSectionController: ListDisplayDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
        let cachedProduct = self.items[index]
        let currentIndex = index

        guard let realm = try? Realm(), let product = realm.object(ofType: Product.self, forPrimaryKey:cachedProduct.id) else { return }
        
        if product.cachedThumbnailImage() == nil {
            product.refreshThumbnailImage { (image) in
                
                DispatchQueue.main.async {
                    
                    if let cell = self.collectionContext?.cellForItem(at: currentIndex, sectionController: sectionController) as? ProductCell {
                        cell.thumbImageView?.image = image
                    }
                }
            }
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {}
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {}
}
