//
//  DataManagerError.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

public enum DataManagerError: Error {
    
    case noNetwork
    case noRecords
    case unknown(error:Error?)
}

public extension DataManagerError {
    
    public var localizedDescription: String {
        switch self {
        case .noNetwork:
            return "Network Error. Please check your internet connection and try again."
        case .noRecords:
            return "No Records Found"
        case .unknown(let error):
            
            var message =  "Oops! Looks like there is service glitch!"
            
            if let error = error as NSError? {
                message.append(" Error Code : \(error.code)")
            }
            return message
        }
    }
}
