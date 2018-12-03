//
//  Search.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift

extension DataManager {
    
    public func catalogueSearch(query: DataManagerQuery, completion: @escaping (DataManagerResult<Bool>) -> Void) -> Void {
        
        let request = APIRequest.catalogueSearchRequest(query: query)
        self.sendRequest(urlRequest: request) { (status, responseJson, error) -> (Void) in
            
            var result = DataManagerResult<Bool>.failure(DataManagerError.unknown(error: error))
            
            guard let realmBg = try? Realm(),
                let responseJson = responseJson as? [String : Any],
                let data = responseJson["products"] as? [[String : Any]] else {
                    DispatchQueue.main.sync { completion (result) }; return
            }
            
            for content in data {

                try? realmBg.write {
                    realmBg.create(Product.self, value: Product.inputJSON(json: content), update: true)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                result = DataManagerResult.success(true)
                completion(result)

            })
//            DispatchQueue.main.sync {
//                result = DataManagerResult.success(true)
//                completion(result)
//            }
        }
    }
}
