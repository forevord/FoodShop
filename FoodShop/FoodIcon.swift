//
//  FoodIcon.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 14.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class FoodIcon: NSObject {
    var icoToCategory = ""
    
    func pictureOfCategory (CategoryID:Int) ->String{
        switch CategoryID {
            case 1: icoToCategory = "pizza_slice.png"
            case 2: icoToCategory = "cookies.png"
            case 3: icoToCategory = "trash_empty.png"
            case 5: icoToCategory = "sushi.png"
            case 6: icoToCategory = "sup.png"
            case 7: icoToCategory = "asian_chicken_salad.png"
            case 8: icoToCategory = "toast.png"
            case 9: icoToCategory = "coffee.png"
            case 10: icoToCategory = "cake.png"
            case 18: icoToCategory = "flag_of_japan.png"
            case 20: icoToCategory = "french_fries.png"
            case 23: icoToCategory = "addons.png"
            case 24: icoToCategory = "meat.png"
            case 30: icoToCategory = "snack.png"
            default: icoToCategory = "food.png"
        }
        return icoToCategory
    }
}

