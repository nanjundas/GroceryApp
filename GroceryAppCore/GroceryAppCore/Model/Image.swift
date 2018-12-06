//
//  Image.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 6/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift
import Kingfisher

final public class Image: Object {
    
    @objc public fileprivate(set) dynamic var position: Int = 0
    @objc public fileprivate(set) dynamic var name: String = NA
    
    fileprivate func imageKey(_ imagePath: String) -> String {
        return "ProductImage" + imagePath
    }
    
    public func cachedImage() -> UIImage? {
        
        let thumbnailImageKey = imageKey(self.name)
        
        return ImageCache.default.retrieveImageInDiskCache(forKey: thumbnailImageKey)
    }
    
    public func refreshImage(_ block: @escaping (_ image: UIImage?) -> Void) -> Void {
        
        let thumbnailImageKey = imageKey(self.name)
        
        DataManager.sharedInstance.downloadImage(imageUrl: self.name ) { (result) in
            
            if let data = result.value, let image = UIImage(data: data) {
                
                ImageCache.default.store(image,
                                         original: data,
                                         forKey: thumbnailImageKey,
                                         toDisk: true)
                block(image)
            }
            else {
                block(nil)
            }
        }
    }
}
