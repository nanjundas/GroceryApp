//
//  URLRequest_Base.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

internal extension URLRequest {
    
    //MARK: -  Defines
    typealias HTTPHeaders = [String: String]
    
    private enum HTTPMethod: String {
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
    
    private func defaultHeader() -> NSDictionary{
        return ["Content-Type" : "application/json"] as NSDictionary
    }
    
    private static func userTokenHeader() -> HTTPHeaders {
        return [:]
    }
    
    //MARK: -  LifeCycle
    private init(url: URL, method: HTTPMethod, headers: HTTPHeaders?, body: NSDictionary?) {
        
        self.init(url: url)
        
        timeoutInterval = 10;
        cachePolicy = .reloadRevalidatingCacheData
        httpShouldUsePipelining = true;
        httpMethod = method.rawValue
        
        let allHeader: NSMutableDictionary = defaultHeader().mutableCopy() as! NSMutableDictionary
        if let _ = headers {
            allHeader.addEntries(from: headers!)
        }
        
        for (headerField, headerValue) in allHeader{
            setValue(headerValue as? String, forHTTPHeaderField: (headerField as? String)!)
        }
        
        if let body:NSDictionary = body {
            if JSONSerialization.isValidJSONObject(body) {
                httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            else {
                print("Invalid Request Format", url.absoluteString, body)
            }
        }
    }
    
    //MARK: -  Helper
    static internal func getRequest (url: URL, headers: HTTPHeaders = [:]) -> URLRequest{
        return URLRequest.init(url: url, method: .get, headers: headers, body: nil)
    }
    
    static internal func getRequest (url: URL, headers: HTTPHeaders?, body: NSDictionary?) -> URLRequest{
        return URLRequest.init(url: url, method: .get, headers: headers, body: body)
    }
    
    static internal func postRequest (url: URL, headers: HTTPHeaders?, body: NSDictionary?) -> URLRequest{
        return URLRequest.init(url: url, method: .post, headers: headers, body: body)
    }
}
