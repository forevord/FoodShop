//
//  ProductListTableViewController.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 21.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    var productsOfferArray = [FoodOffer]()
    var categoryIDSender = 0
    var filteredArrayOfProducts = [FoodOffer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        switchIDtoLoadCategories(categoryIDSender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchIDtoLoadCategories (ID:Int)->[FoodOffer]{
        print("ID to come:\(ID)")
        let arrayOBJ = productsOfferArray
        let filteredArray = arrayOBJ.filter() { $0.categoryID == ID }
            print("Unsort:\(arrayOBJ.count)")
            print("Sorted:\(filteredArray.count)")
        filteredArrayOfProducts = filteredArray
        return filteredArrayOfProducts
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArrayOfProducts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! ProductListTableViewCell
        let product = filteredArrayOfProducts[indexPath.row]
            cell.productListTitle.text = product.name
            cell.productListWeight.text = product.weight
            cell.productListCost.text = product.price
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProductSegue" {
            if let destination = segue.destinationViewController as? OneProductViewController {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                let productResult = filteredArrayOfProducts[(path?.row)!]
                destination.oProductTitle = productResult.name
                destination.oProductDescription = productResult.offerDescription
                destination.oProductWeight = productResult.weight
                destination.oProductCost = productResult.price
                //destination.oneProductImage = categoryResult.picture
            }
        }
    }

}
