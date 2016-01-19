//
//  ExSlideMenuController.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 18.01.16.
//  Copyright © 2016 Pavel Salkevich. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is CategoryTableViewController ||
                vc is MapViewController {
                    return true
            }
        }
        return false
    }
}
