//
//  FeelmManager.swift
//  Feelm
//
//  Created by feel on 2020/07/10.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import UIKit

class FeelmManager: NSObject {
    static var instance:FeelmManager?
    
    static public func defaultManager()->FeelmManager{
        if instance == nil {
            instance = FeelmManager.init()
        }
        return instance!
    }
}
