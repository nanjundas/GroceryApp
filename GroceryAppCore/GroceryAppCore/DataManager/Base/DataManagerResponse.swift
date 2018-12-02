//
//  DataManagerResponse.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift

public class DataManagerResponse<Value>: NSObject {
    
    public var networkToken: String?
    
    public var recordsFound: Int {
        return apiCompletion.recordsFound
    }
    
    public var records: Value?
    
    internal var apiCompletion: APIResponse
    
    convenience init(apiCompletion: APIResponse) {
        self.init()
        self.apiCompletion = apiCompletion
    }
    
    public override init() {
        apiCompletion = APIResponse()
    }
}
