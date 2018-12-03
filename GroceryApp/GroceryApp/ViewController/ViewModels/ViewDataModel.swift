//
//  ViewDataModel.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import RealmSwift
import GroceryAppCore

internal class BaseViewDataModel { }


protocol ViewDataModelRefreshProtocol {
    func modelDidRefresh(object: Any, error: Error?)
}

internal class ViewDataModel: BaseViewDataModel {
    
    static let PageSize = 30
    
    var token: NotificationToken?
    
    var delegate: ViewDataModelRefreshProtocol?
    var recordsFound: Int = 0
    
    deinit {
        token?.invalidate()
    }
    
    open func refreshFeed(forceLoad: Bool = false, callback: @escaping (_ error: Error?) -> Void) -> Void {
        
    }
    
    open func populateData(cache: Bool = true) {
        
    }
    
    open func loadNextPage(callback: @escaping (_ error: Error?) -> Void) -> Void {
        
    }
}
