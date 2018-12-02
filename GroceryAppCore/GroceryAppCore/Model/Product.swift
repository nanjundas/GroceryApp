//
//  Product.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift

final public class Product: Object {

    @objc public fileprivate(set) dynamic var id: Int = 0
    @objc public fileprivate(set) dynamic var title: String = NA
    @objc public fileprivate(set) dynamic var desc: String = NA
    @objc public fileprivate(set) dynamic var sku: String = NA

    public override class func primaryKey() -> String{
        return "id"
    }
}


extension Product: ObjectProtocol {
    
    static func inputJSON(json: [String : Any]) -> [String : Any] {
        return json
    }
    
    func updateObject(json: [String : Any]) {
        
    }
}

