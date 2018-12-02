//
//  APIRequest.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

internal class APIRequest {
    
    static internal func catalogueSearchRequest(query: DataManagerQuery) -> URLRequest {
        
        let url = URLEncoder.requestURL(path: .catalogSearch, queryParam: ["pageSize" : String(query.recordsPerPage),
                                                                           "page" : String(query.startPage)])
        return URLRequest.getRequest(url: url)
    }
}
