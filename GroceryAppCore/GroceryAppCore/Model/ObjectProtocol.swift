//
//  ObjectProtocol.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

internal protocol ObjectProtocol {
    
    static func inputJSON(json: [String : Any]) -> [String : Any]
    
    func updateObject(json: [String : Any])
}
