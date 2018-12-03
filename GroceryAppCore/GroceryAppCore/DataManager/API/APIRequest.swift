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
        
        var params = query.params
        params["pageSize"] = String(query.recordsPerPage)
        params["page"] = String(query.startPage)
        
        let url = URLEncoder.requestURL(path: .catalogSearch, queryParam: params as! URLEncoder.QueryParams)
        return URLRequest.getRequest(url: url)
    }
    
    static internal func imageDownloadRequest(path: String) -> URLRequest {
     
        let url = URL(string: BaseURL.imageBaseUrl + path)!
        
        return URLRequest.getRequest(url: url)
    }
}
