//
//  CacheProtocol.swift
//  ToDo
//
//  Created by Thomas Röthemeyer on 01/01/2016.
//  Copyright © 2016 Thomas Röthemeyer. All rights reserved.
//

import Foundation

protocol CacheProtocol {
    
    func loadObjectForKey(key: String) -> AnyObject?
    
    func saveObject(object: AnyObject, key: String)
    
}
