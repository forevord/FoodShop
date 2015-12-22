//
//  FoodCategory.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 14.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class FoodCategory: NSObject {
    
    var ID :Int = 0
    var name :String = ""
    var offers = []
    
    init (ID:Int, name:String) {
        
        self.ID = ID
        self.name = name
    }
    
}
