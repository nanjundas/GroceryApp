//
//  URLEncoder.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation


internal class URLEncoder: NSObject {
    
    typealias QueryParams = [String: String]
    
    internal class func requestURL(path: URLPath, queryParam: QueryParams = [:]) -> URL {
        
        let url = URL.init(string: path.urlPath, relativeTo: URL(string: BaseURL.value)!)
        
        var components = URLComponents.init(string: url!.absoluteString)
        var queryItems = [URLQueryItem]()
        
        for(key, value) in queryParam {
            queryItems.append((URLQueryItem.init(name: key, value: value)))
        }
        
        components?.queryItems = queryItems
        
        return (components?.url)!
    }
}
