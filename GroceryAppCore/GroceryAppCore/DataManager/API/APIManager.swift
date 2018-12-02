//
//  APIManager.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation

internal typealias APIManagerCompletion = (_ status:Int, _ object: Any? , _ error: DataManagerError?) -> Void

internal class APIManager: NSObject {

    public static let sharedInstance = APIManager()
    
    private var container = [String: APIOperation]()
    
    @discardableResult internal func addOperation(operation: APIOperation.Type, query: DataManagerQuery, completion:@escaping APIManagerCompletion) -> String {
        
        let operationObj = operation.init(query: query)
        operationObj.completionHandler = { (status, object, error) -> (Void) in
            
            if operationObj.isCancelled == false {
                completion(status, object, error)
            }
            
            self.container.removeValue(forKey: operationObj.uuidString)
        }
        
        container[operationObj.uuidString] = operationObj
        
        operationObj.start()
        
        return operationObj.uuidString
    }
    
    internal func cancelOperations(operationIDs: [String]) {
        
        sync(lock: container) {
            
            for operationID in operationIDs {
                
                if let operation = container[operationID] {
                    operation.cancel()
                    
                    NSLog("Cancelling - %@ - %@", operationID, operation)
                    
                    container.removeValue(forKey: operationID)
                }
            }
        }
    }

    internal func cancelOperation(operation:APIOperation.Type) {
        
        sync(lock: container) {
            
            var cancelled:Array<String> = []
            
            let name = String(describing:operation)
            
            for (key, object) in container {
                
                if(String(describing:type(of: object)) == name){
                    (object as APIOperation).cancel()
                }
                
                cancelled.append(key)
            }
            
            for (removedObjs) in cancelled{
                container.removeValue(forKey: removedObjs)
            }
        }
    }
    
    internal func cancelAllOperations() {
        
        sync(lock: container) {
            
            for (object) in container.values {
                object.cancel()
            }
            
            container.removeAll()
        }
    }
    
    private func sync(lock: Any, closure: () -> Void) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}
