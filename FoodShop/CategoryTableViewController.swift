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
    var dict = [String:String]()
    var CategoryArray = [FoodCategory]()
    var OfferArray = [FoodOffer]()
    var result = Array<FoodCategory>()
    
  //  var categoryArray = [FoodCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()

        var gg = ServiceManager()
        
        
        // Call
        asynchronousWork { (inner: () throws -> [FoodCategory]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
            do {
                let result = try inner()
                print("Finish")
                print("Result:\(result)")
                self.tableView?.reloadData()
            } catch let error {
                print(error)
            }
                })
        }
        
        
        
        //раскоментить
//        ServiceManager.loadCategory(1) { (category, error) -> Void in
//            if error != nil {
//                print("Error")
//            } else {
//                print("All is OK")
//                print("categoryArray - \(self.categoryArray)")
//                print("category \(category)")
//            }
//            
//        }
        //---------
        
//        ServiceManager.loadCategory(completionHandler: [FoodCategory], error) (completionHandler: { category, error in
//            if error != nil {
//                print("Error")
//            } else {
//                self.tableView?.reloadData()
//            }
//            completionHandler()
//        })
//        
    }
    
    func asynchronousWork(completion: (inner: () throws -> [FoodCategory]) -> Void) -> Void {
        let queue = NSOperationQueue()
        let request: NSURLRequest = NSURLRequest(URL: Constants.baseUrl!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) {
            (response, data, error) -> Void in
            guard let data = data else { return }
            do {
                let resultX = NSURLSession.sharedSession().dataTaskWithURL(Constants.baseUrl!)
                let xmlDoc = try AEXMLDocument(xmlData: data)
                //MARK - парсим категории (ID/имена)
                for categoryParam in xmlDoc.root["shop"]["categories"]["category"].all! {
                    
                    let name = categoryParam.value!
                    let id = Int (categoryParam.attributes["id"]!)!
                    let category = FoodCategory.init(ID: id, name: name)
                    self.CategoryArray.append(category)
                    self.result.append(category)
                    print(name,id)
                }
                
                //MARK - парсим товары
                for offerParam in xmlDoc.root["shop"]["offers"]["offer"].all! {
                    let id = offerParam.attributes["id"]!
                    self.dict["id"] = id
                    for param in offerParam.children{
                        let weight = param.attributes
                        let trueWeight = weight["name"]
                        let name = param.name
                        let value = param.value ?? ""
                        switch name {
                        case "name": self.dict["name"] = value
                        case "param" where trueWeight=="Вес": self.dict["weight"] = param.stringValue
                        case "categoryId": self.dict["categoryId"] = value
                        case "picture": self.dict["picture"] = value
                        case "price": self.dict["price"] = value
                        case "description": self.dict["description"] = value
                        default :break
                        }
                    }
                    //print("Dict - \(dict)")
                    let products = FoodOffer.init(ID: Int(self.dict["id"]!)!, categoryID: Int(self.dict["categoryId"]!)!, name: self.dict["name"]!, price: self.dict["price"]!, offerDescription: self.dict["description"]!, weight: self.dict["weight"]!, picture: self.dict["picture"]!)
                    self.OfferArray.append(products)
                    
                    //                    print("Тест - ID:\(products.ID) categoryID:\(products.categoryID) name: \(products.name) price: \(products.price) Desc: \(products.offerDescription) weight:\(products.weight) picture: \(products.picture)")
                }
                
                print(self.result)
                completion(inner: {return self.result})
            } catch let error {
                completion(inner: {throw error})
            }
        }
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
        cell.titleCategory.text = category.name
        print("ID for send:\(category.ID)")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendDataSegue" {
            if let destination = segue.destinationViewController as? ProductListTableViewController {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                //destination.textLabelProduct = (cell?.textLabel?.text!)!
                let categoryResult = result[(path?.row)!]
                destination.categoryIDSender = categoryResult.ID
                destination.productsOfferArray = OfferArray
                print("Destination: \(destination.categoryIDSender)")
            }
        }
    }

}
