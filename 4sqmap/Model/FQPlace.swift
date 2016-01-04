//
//  FQPlace.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/30/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class FQPlace : NSObject{
    var id:String
    var name:String
    var location:CLLocation
    var address:String
    var icon:String
    var catagory:String

    
    init(data : NSDictionary){
        id = data.valueForKey("id") as! String
        name = data.valueForKey("name") as! String
        
        let loc = data.valueForKey("location")
        location = CLLocation(latitude: loc?.valueForKey("lat") as! Double, longitude: loc?.valueForKey("lng") as! Double)
        address = (loc?.valueForKey("formattedAddress") as! Array).joinWithSeparator(", ")
        
        let categories = (data.valueForKey("categories") as! NSArray)
        
        if categories.count > 0 {
            
            let catDic = categories[0] as! NSDictionary
            
            icon = "\(catDic.valueForKey("icon")?.valueForKey("prefix") as! String)bg_64\(catDic.valueForKey("icon")?.valueForKey("suffix") as! String)"
            catagory = catDic.valueForKey("name") as! String
        }
        else{
            icon = "https://ss3.4sqi.net/img/categories_v2/building/default_bg_64.png"
            catagory = "None"
        }
    }
}