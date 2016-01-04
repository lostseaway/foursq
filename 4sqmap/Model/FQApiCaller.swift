//
//  FQApiCaller.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/30/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class FQApiCaller {
    private let client_id = "QPKA105TQW5L3ETZ12R311S5JVI4NF2KSRI3ETN2NJ2SJMBN"
    private let client_secret = "IPGNIYF5OATICKCUEAVK40CKNH3RIINQH30G5EWWVORSWIXK"
    private let url = "https://api.foursquare.com/v2/"
    
    func loadNearbyPlace(currentLocation : CLLocation,block:(success:Bool!, response:[FQPlace], error:Error?) -> Void){
        let query = "\(url)venues/search?client_id=\(client_id)&client_secret=\(client_secret)&ll=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&v=20140806&m=foursquare"
        
        Alamofire.request(.GET, query).responseJSON {
            response in
            if let responseCode = response.response?.statusCode {
                if responseCode == 200{
                    let data = response.result.value as! NSDictionary
                    let out = self.createPlace(data)
                    block(success: true, response: out, error: nil)
                }
            }

        }
    }
    
    func searchPlaces(currentLocation : CLLocation,query : String , block:(success:Bool!, response:[FQPlace], error:Error?) -> Void){
        let query = "\(url)venues/search?client_id=\(client_id)&client_secret=\(client_secret)&ll=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&v=20140806&m=foursquare&query=\(query)"

        Alamofire.request(.GET, query).responseJSON {
            response in
            if let responseCode = response.response?.statusCode {
                
                if responseCode == 200{
                    
                    let data = response.result.value as! NSDictionary
                    let out = self.createPlace(data)
                    block(success: true, response: out, error: nil)
                }
            }
            
        }
    }
    
    
    private func createPlace(response : NSDictionary)->[FQPlace]{
        let venuse = response.valueForKey("response")?.valueForKey("venues") as! NSArray
        var out = [FQPlace]()
        for place in venuse {
            out.append(FQPlace(data: place as! NSDictionary))
        }
        return out
    }
    
    

}
