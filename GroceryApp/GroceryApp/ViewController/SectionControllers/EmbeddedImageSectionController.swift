//
//  EmbeddedImageSectionController.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 6/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import IGListKit
import RealmSwift
import UIKit
import GroceryAppCore

final class EmbeddedImageSectionController: ListSectionController {
    
    private var image: Image?
    
    override init() {
        super.init()
        displayDelegate = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: width)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell else {
            fatalError()
        }
        
        cell.imageView.image = image?.cachedImage()
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        image = object as? Image
    }
}

extension EmbeddedImageSectionController: ListDisplayDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
        let currentIndex = index

        if image?.cachedImage() == nil {
            image?.refreshImage { (image) in
                
                DispatchQueue.main.async {
                    
                    if let cell = self.collectionContext?.cellForItem(at: currentIndex, sectionController: sectionController) as? ImageCell {
                        cell.imageView.image = image
                    }
                }
            }
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {}
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {}
}

