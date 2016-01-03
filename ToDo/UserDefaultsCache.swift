//
//  UserDefaultsCache.swift
//  ToDo
//
//  Created by Thomas Röthemeyer on 01/01/2016.
//  Copyright © 2016 Thomas Röthemeyer. All rights reserved.
//

import Foundation

class UserDefaultsCache: CacheProtocol {
    
    func loadObjectForKey(key: String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
    
    func saveObject(object: AnyObject, key: String) {
        NSUserDefaults.standardUserDefaults().setObject(object, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()        
    }
    
}