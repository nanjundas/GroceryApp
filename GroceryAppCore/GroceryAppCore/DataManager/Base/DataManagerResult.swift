//
//  DataManagerResult.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

public enum DataManagerResult <Value> {
    
    case success(Value)
    case failure(DataManagerError)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
}

extension DataManagerResult: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
}

extension DataManagerResult: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}
