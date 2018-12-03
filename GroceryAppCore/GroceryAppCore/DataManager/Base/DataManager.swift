//
//  DataManager.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift

public class DataManager: NSObject {
    
    internal override init() {
        
        #if (arch(i386) || arch(x86_64))
        logToConsole = true
        #else
        logToConsole = true
        #endif
        
        urlSessionConfiguration =  URLSessionConfiguration.default
        
        if let realm = try? Realm(){
            var config = realm.configuration
            config.encryptionKey = "TveURqLYbegZHbHi4KOP3l5Xgo7vZ76yWUaA0DoHV2UJhqt3dUIpb7M206Pc5s69".data(using: String.Encoding.utf8)
            config.deleteRealmIfMigrationNeeded = true
        }
    }
    
    typealias DataManagerCompletion = (_ status:Int, _ object: Any? , _ error: Error?) -> (Void)
    
    internal var urlSessionConfiguration : URLSessionConfiguration
    internal lazy var urlSession:URLSession = {
        return URLSession(configuration: urlSessionConfiguration, delegate: self, delegateQueue: nil)
    }()
    
    public static let sharedInstance = DataManager()
    public var logToConsole: Bool = true
    
    internal func sendRequest(urlRequest: URLRequest, callback: @escaping DataManagerCompletion) -> Void {
        
        let start = CACurrentMediaTime()
        
        let task = urlSession.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            let end = CACurrentMediaTime()
            
            let httpResponse = response as? HTTPURLResponse
            
            var responseJson:Any?
            if data != nil {
                do {
                    responseJson = try JSONSerialization.jsonObject(with: (data)!, options: [])
                }
                catch{
                    print(error)
                }
            }
            
            if (self.logToConsole) {
                
                print("========================================================================")
                print("URL :", urlRequest.url?.absoluteString ?? "null")
                print("METHOD :", urlRequest.httpMethod ?? "GET")
                
                if(urlRequest.httpMethod == "POST" && (urlRequest.httpBody != nil)){
                    
                    let bodyJson = try? JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    
                    print("BODY :", bodyJson ?? "null")
                }
                
                print("Time Taken : \((end - start)as NSNumber) secs")
                if let httpResponse = response {
                    print("StatusCode :", (httpResponse as! HTTPURLResponse).statusCode)
                }
                
                print("Response JSON : \(String(describing: responseJson == nil ? "null" : responseJson))")
                print("Error : \(String(describing: error == nil ? "null": error?.localizedDescription))")
                print("========================================================================")
            }
            
            callback(httpResponse?.statusCode ?? 999, responseJson, error)
        })
        
        task.resume()
    }
    
    internal func onComplete<T>(completion:(_ result: DataManagerResult<T>) -> Void, result: DataManagerResult<T>) {
        
        DispatchQueue.main.sync {
            
            if let realm = try? Realm () {
                realm.refresh()
            }
            
            completion(result)
        }
    }
}

extension DataManager: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, (challenge.protectionSpace.serverTrust != nil) ? URLCredential(trust: challenge.protectionSpace.serverTrust!) : nil)
    }
}
