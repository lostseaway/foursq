//
//  FQManager.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/31/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import Foundation
import CoreLocation

class FQManager{
    static let sharedInstance = FQManager()
    private var currentLocation : CLLocation?
    private var nearbyPlace : [FQPlace]?
    private var caller : FQApiCaller?
    
    init(){
        caller = FQApiCaller()
    }
    
    func getNearbyPlaces(currentLocation : CLLocation,block:(success:Bool!, response:[FQPlace]) -> Void){
        if self.currentLocation?.coordinate.latitude == currentLocation.coordinate.latitude && self.currentLocation?.coordinate.longitude == currentLocation.coordinate.longitude && nearbyPlace != nil {
            
            block(success: true,response: self.nearbyPlace!)
            
        }else{
            self.currentLocation = currentLocation
            self.caller?.loadNearbyPlace(self.currentLocation!){success,response,error in
                self.nearbyPlace = response
                block(success: true, response: self.nearbyPlace!)
            }
            
        }
    }
    
    func getNearbyPlaces()->[FQPlace]{
        if nearbyPlace == nil{
            return []
        }
        return nearbyPlace!
    }
    
    func getPlacesByName(name : String)->FQPlace?{
        for place in nearbyPlace! {
            if place.name == name {
                return place
            }
        }
        return nil
    }

    func searchPlace(currentLocation : CLLocation,query : String,block:(success:Bool!, response:[FQPlace])->Void){
        caller?.searchPlaces(currentLocation, query: query){success,response,error in
            block(success: true, response: response)
        }
    }
    
    func searchPlace(query : String,block:(success:Bool!, response:[FQPlace])->Void){
        caller?.searchPlaces(currentLocation!, query: query){success,response,error in
            block(success: true, response: response)
        }
    }
    
    
}
