//
//  OneProductViewController.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 22.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class OneProductViewController: UIViewController {
    @IBOutlet weak var oneProductImage: UIImageView!
    @IBOutlet weak var oneProductTitle: UILabel!
    @IBOutlet weak var oneProductDescriprion: UILabel!
    @IBOutlet weak var oneProductWeight: UILabel!
    @IBOutlet weak var oneProductCost: UILabel!
    
        var oProductImage = UIImage(named:"load.png")
        var oProductTitle = ""
        var oProductDescription = ""
        var oProductWeight = ""
        var oProductCost = ""

    override func viewDidLoad() {
        super.viewDidLoad()
            oneProductTitle.text = oProductTitle
            oneProductDescriprion.text = oProductDescription
            oneProductWeight.text = "Вес: "+oProductWeight
            oneProductCost.text = "Цена: "+oProductCost
            oneProductImage.image = oProductImage
        
//        всё работает
//        if let url = NSURL(string: oProductImage) {
//            let request = NSURLRequest(URL: url)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
//                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//                dispatch_async(dispatch_get_main_queue()) {
//                    var image = UIImage(data:data!)!
//                    self.oneProductImage.image = image
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
