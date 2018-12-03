//
//  Download.swift
//  GroceryAppCore
//
//  Created by Nanjundaswamy Sainath on 3/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import Kingfisher

extension DataManager {
    
    @discardableResult public func downloadImage(imageUrl: String,  completion:@escaping (_ result: DataManagerResult<Data>) -> Void) -> URLSessionTask {
        
        let request = APIRequest.imageDownloadRequest(path: imageUrl)
        let task = self.urlSession.downloadTask(with: request) { (fileUrl, response, error) in
            
            var result = DataManagerResult<Data>.failure(DataManagerError.unknown(error: error))
            
            if let fileUrl = fileUrl, let data = FileManager.default.contents(atPath: fileUrl.path){
                result = DataManagerResult.success(data)
            }
            
            completion(result)
        }
        
        task.priority = URLSessionTask.lowPriority
        task.resume()
        
        return task
    }
    
}
