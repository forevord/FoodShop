//
//  ViewController.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 14.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gg = ServiceManager()
    ServiceManager.loadCategory(1) { (category, error) -> Void in
        if error != nil {
            print("Error")
        } else {
            print("All is OK")
            
        }
        
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

