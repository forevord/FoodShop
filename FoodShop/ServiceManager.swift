//
//  ServiceManager.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 14.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit
import AEXML

class ServiceManager: NSObject {
    
    //------------------------------------
    
     func asynchronousWork(completion: (inner: () throws -> NSDictionary) -> Void) -> Void {
        let queue = NSOperationQueue()
        let request: NSURLRequest = NSURLRequest(URL: Constants.baseUrl!)

        NSURLConnection.sendAsynchronousRequest(request, queue: queue) {
            (response, data, error) -> Void in
            guard let data = data else { return }
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    as! NSDictionary
                print(result)
                completion(inner: {return result})
            } catch let error {
                completion(inner: {throw error})
            }
        }
    }
    
    
    
    
    //------------------------------------
 
    
     static func loadCategory (pageNumber:UInt, completionHandler: ([FoodCategory], NSError?) -> Void) {
        
        print("Start parsing!")
        
        var dict = [String:String]()
        var CategoryArray = [FoodCategory]()
        var OfferArray = [FoodOffer]()

        let task = NSURLSession.sharedSession().dataTaskWithURL(Constants.baseUrl!) { data, response, error in
            if error != nil {
                print(error)
                completionHandler([], error)
                return
            }
            do {
                let xmlDoc = try AEXMLDocument(xmlData: data!)
                print ("Спарсилось:")
                
               // print(xmlDoc.xmlString)
              
                //MARK - парсим категории (ID/имена)
                for categoryParam in xmlDoc.root["shop"]["categories"]["category"].all! {
                    
                    let name = categoryParam.value!
                    let id = Int (categoryParam.attributes["id"]!)!
                    let category = FoodCategory.init(ID: id, name: name)
                    CategoryArray.append(category)
                    print(name,id)
                }
                
                //MARK - парсим товары
                for offerParam in xmlDoc.root["shop"]["offers"]["offer"].all! {
                let id = offerParam.attributes["id"]!
                    dict["id"] = id
                    for param in offerParam.children{
                        let weight = param.attributes
                        let trueWeight = weight["name"]
                        let name = param.name
                        let value = param.value ?? ""
                        switch name {
                            case "name": dict["name"] = value
                            case "param" where trueWeight=="Вес": dict["weight"] = param.stringValue
                            case "categoryId": dict["categoryId"] = value
                            case "picture": dict["picture"] = value
                            case "price": dict["price"] = value
                            case "description": dict["description"] = value
                        default :break
                        }
                    }
                    //print("Dict - \(dict)")
                    let products = FoodOffer.init(ID: Int(dict["id"]!)!, categoryID: Int(dict["categoryId"]!)!, name: dict["name"]!, price: dict["price"]!, offerDescription: dict["description"]!, weight: dict["weight"]!, picture: dict["picture"]!)
                    OfferArray.append(products)
//                    print("Тест - ID:\(products.ID) categoryID:\(products.categoryID) name: \(products.name) price: \(products.price) Desc: \(products.offerDescription) weight:\(products.weight) picture: \(products.picture)")
                }
            }
            catch {
                print("\(error)")
            }
            print("--------------------------------")
            print("Всего категорий спарсилось:\(CategoryArray.count)")
            print("Всего товаров спарсилось:\(OfferArray.count)")
            print("--------------------------------")
        }
        task.resume()
        completionHandler(CategoryArray, nil)
        
}
}

        