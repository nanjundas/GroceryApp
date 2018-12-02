//
//  DataManagerQuery.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

public final class DataManagerQuery: NSObject {
    
    public var startPage: Int = 0
    public var recordsPerPage: Int = 30
    
    public var params: Dictionary<String, Any> = [:]
}
