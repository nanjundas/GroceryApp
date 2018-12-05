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
    
    public internal(set) var images = List<Image>()
    
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
        
        if let imageJson = json["images"] as? [[String:Any]] {
           input["images"] = imageJson
        }
        
        return input
    }
    
    func updateObject(json: [String : Any]) {
        
    }
}

extension Product {
    
    public func cachedThumbnailImage() -> UIImage? {
        
        if let image = self.images.first {
            return image.cachedImage()
        }
        
        return nil
    }
    
    public func refreshThumbnailImage(_ block: @escaping (_ image: UIImage?) -> Void) -> Void {
        
        if let image = self.images.first {
            
            image.refreshImage { (image) in                
                block(image)
            }
        }
    }
}
