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
    var dict1 = [String:String]()
    var CategoryArray1 = [FoodCategory]()
    var OfferArray1 = [FoodOffer]()
    var result1 = Array<FoodCategory>()
    var imageLoading = UIImage()
    
    func asynchronousWorkLoading(completion: (inner: () throws -> [FoodCategory]) -> Void) -> Void {
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
                    self.CategoryArray1.append(category)
                    self.result1.append(category)
                    print(name,id)
                }
                //MARK - парсим товары
                for offerParam in xmlDoc.root["shop"]["offers"]["offer"].all! {
                    let id = offerParam.attributes["id"]!
                    self.dict1["id"] = id
                    for param in offerParam.children{
                        let weight = param.attributes
                        let trueWeight = weight["name"]
                        let name = param.name
                        let value = param.value ?? ""
                        switch name {
                        case "name": self.dict1["name"] = value
                        case "param" where trueWeight=="Вес": self.dict1["weight"] = param.stringValue
                        case "categoryId": self.dict1["categoryId"] = value
                        case "picture": self.dict1["picture"] = value
                        case "price": self.dict1["price"] = value
                        case "description": self.dict1["description"] = value
                        default :break
                        }
                    }
                    //print("Dict - \(dict)")
                    let products = FoodOffer.init(ID: Int(self.dict1["id"]!)!, categoryID: Int(self.dict1["categoryId"]!)!, name: self.dict1["name"]!, price: self.dict1["price"]!, offerDescription: self.dict1["description"]!, weight: self.dict1["weight"]!, picture: self.dict1["picture"]!)
                    self.OfferArray1.append(products)
                }
               // print(self.result1)
                completion(inner: {return self.result1})
            } catch let error {
                completion(inner: {throw error})
            }
        }
    }
    
    static func imageFromUrl(urlString: String)->UIImage{
            var imageToLoad = UIImage()
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                var image = UIImage(data:data!)!
                    imageToLoad = image
                    print("Img \(image)")
                }
            }
        }
        print("return \(imageToLoad)")
         return imageToLoad
    }
}



        