//
//  ViewController.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/30/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import AlamofireImage
import Alamofire

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    
    private var currentPositionMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var manager : FQManager = FQManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
    }
    

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if CLLocationManager.locationServicesEnabled()
            && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways{
            print("in")
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            print("My Location : \(location.coordinate)")
            mapView.clear()
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            updateCurrentPositionMarker(location)
            
            self.manager.getNearbyPlaces(location){
                success, response in
                self.addNearbyPlace(response)
            }
            
        }
        
    }
    
    func updateCurrentPositionMarker(currentLocation: CLLocation) {
        self.currentPositionMarker.map = nil
        self.currentPositionMarker = GMSMarker(position: currentLocation.coordinate)
        self.currentPositionMarker.icon = GMSMarker.markerImageWithColor(UIColor.cyanColor())
        self.currentPositionMarker.map = self.mapView
    }
    
    func addNearbyPlace(places : [FQPlace]){
        for place in places {

            let marker = GMSMarker(position: place.location.coordinate)
            Alamofire.request(.GET, place.icon).responseImage{ response in
                if let image = response.result.value {
                    marker.icon = image
                    marker.title = place.name
                }
            }
            marker.map = self.mapView
        }
    }
    
    func addPlaceAndMove(place : FQPlace){
        let marker = GMSMarker(position: place.location.coordinate)
        Alamofire.request(.GET, place.icon).responseImage{ response in
            if let image = response.result.value {
                marker.icon = image
                marker.title = place.name
            }
        }
        marker.map = self.mapView
        mapView.camera = GMSCameraPosition(target: place.location.coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
    }
    
    
}

extension MapViewController : GMSMapViewDelegate{
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        print("Marker :\(marker)")
        
        (self.slideMenuController()?.rightViewController as! RightMenuViewController).place
            = self.manager
        .getPlacesByName(marker.title)

        self.slideMenuController()?.openRight()
        return false
    }
    
    
}

