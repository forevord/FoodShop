//
//  FoodOffer.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 14.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class FoodOffer: NSObject {
    
    var ID :Int = 0
    var categoryID :Int = 0
    var name :String = ""
    var price :String = ""
    var offerDescription :String = ""
    var weight :String = ""
    var picture :String = ""
    
    init(ID:Int, categoryID:Int, name:String, price:String, offerDescription:String, weight:String, picture:String) {
        self.ID = ID
        self.categoryID = categoryID
        self.name = name
        self.price = price
        self.offerDescription = offerDescription
        self.weight = weight
        self.picture = picture
    }

}
