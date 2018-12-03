//
//  Product.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift
import Kingfisher

final public class Product: Object {
    
    @objc public fileprivate(set) dynamic var id: Int = 0
    @objc public fileprivate(set) dynamic var title: String = NA
    @objc public fileprivate(set) dynamic var desc: String = NA
    @objc public fileprivate(set) dynamic var sku: String = NA
    @objc public fileprivate(set) dynamic var price: Double = 0
    @objc public fileprivate(set) dynamic var promoPrice: Double = 0
    @objc public fileprivate(set) dynamic var savingsText: String = NA
    
    public internal(set) var images = List<String>()
    
    public override class func primaryKey() -> String{
        return "id"
    }
}


extension Product: ObjectProtocol {
    
    static func inputJSON(json: [String : Any]) -> [String : Any] {
        
        var input:[String : Any] = [:]
        
        input["id"] = json["id"]
        input["title"] = json["title"]
        input["desc"] = json["desc"]
        input["sku"] = json["sku"]
        
        if let pricing = json["pricing"] as? [String : Any] {
            input["price"] = pricing["price"]
            input["promoPrice"] = pricing["promo_price"]
            input["savingsText"] = pricing["savings_text"]
        }
        
        var images: [String] = []
        if let imageJson = json["images"] as? [[String:Any]] {
            
            for image in imageJson{
                images.append(image["name"] as! String)
            }
        }
        input["images"] = images
        
        return input
    }
    
    func updateObject(json: [String : Any]) {
        
    }
}

extension Product {
    
    public func cachedThumbnailImage() -> UIImage? {
        
        let thumbnailImageKey = "ListImage" + self.sku
        
        return ImageCache.default.retrieveImageInDiskCache(forKey: thumbnailImageKey)
    }
    
    public func refreshThumbnailImage(_ block: @escaping (_ image: UIImage?) -> Void) -> Void {
        
        let thumbnailImageKey = "ListImage" + self.sku
        
        if (images.count == 0) {
            block(nil)
            return
        }
        
        DataManager.sharedInstance.downloadImage(imageUrl: images.first ?? "") { (result) in
            
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
