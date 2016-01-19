//
//  CategoryTableViewController.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 15.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit
import AEXML

class CategoryTableViewController: UITableViewController {
    @IBOutlet weak var activityLabel: UIActivityIndicatorView!
    var CategoryArray = [FoodCategory]()
    var OfferArray = [FoodOffer]()
    var result = Array<FoodCategory>()
    let titleLabel = UILabel(frame: CGRect(x: 70, y: 40, width: 200, height: 50))
    var hidesWhenStopped = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(DataTableViewCell.self)
        
        titleLabel.text = "Загрузка данных..."
        activityLabel.frame = CGRectMake(0.0, 50.0, 50.0, 200.0)
        self.view.addSubview(activityLabel)
        self.view.addSubview(titleLabel)
        activityLabel.bringSubviewToFront(self.view)
        activityLabel.startAnimating()
        activityLabel.hidesWhenStopped = true
        let service = ServiceManager()
        service.asynchronousWorkLoading { (inner: () throws -> [FoodCategory]) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let result = try inner()
                    print("-----------------------------")
                    print("Finish Loading With Success!")
                    print("Categories count:\(result.count)")
                    print("-----------------------------")
                    self.tableView?.reloadData()
                } catch let error {
                    print(error)
                }
            })
            self.CategoryArray = service.CategoryArray1
            self.OfferArray = service.OfferArray1
            self.result = service.result1
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategoryTableViewCell
        let category = result[indexPath.row]
        activityLabel.stopAnimating()
        self.titleLabel.removeFromSuperview()
        var imageCategory = FoodIcon()
        cell.titleCategory.text = category.name
        print("Картинки \(imageCategory.pictureOfCategory(category.ID))")
        cell.imageToCategory.image = UIImage(named:imageCategory.pictureOfCategory(category.ID))
        print("ID for send:\(category.ID)")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendDataSegue" {
            if let destination = segue.destinationViewController as? ProductListTableViewController {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                let categoryResult = result[(path?.row)!]
                    destination.categoryIDSender = categoryResult.ID
                    destination.productsOfferArray = OfferArray
                print("Destination: \(destination.categoryIDSender)")
            }
        }
    }

}
