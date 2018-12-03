//
//  URLPath.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

internal struct BaseURL {
    
    static let value: String  = "https://api.redmart.com"
    static let imageBaseUrl: String = "https://media.redmart.com/newmedia/200p"
    
    static let urlVersion = "/v1.6.0"
}

internal enum URLPath {
    
    case catalogSearch

    var urlPath: String {
        var ret = ""
        switch self {
            case .catalogSearch: ret = BaseURL.urlVersion + "/catalog/search"
        }
        
        return ret
    }
}
