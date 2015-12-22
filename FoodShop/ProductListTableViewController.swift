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
    var textLabelProduct = ""
    var categoryIDSender = 0
    var filteredArrayOfProducts = [FoodOffer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   var pList = ProductListTableViewCell()
        switchIDtoLoadCategories(categoryIDSender)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchIDtoLoadCategories (ID:Int)->[FoodOffer]{
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
