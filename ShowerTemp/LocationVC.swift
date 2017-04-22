//
//  LocationVC.swift
//  ShowerTemp
//
//  Created by Nikhil on 4/21/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationVC: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var map: MKMapView!
     var locationManager : CLLocationManager! = CLLocationManager()
     var startLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        findMyLocation()
        
        // Do any additional setup after loading the view.
    }

    func findMyLocation(){
        startLocation = nil
        locationManager.startUpdatingLocation()
    }
    
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation:AnyObject = locations[0] as! CLLocation
    let latitude = String(format: "%.4f", userLocation.coordinate.latitude)
    let longtitude = String(format: "%.4f",userLocation.coordinate.longitude)
    print(latitude)
    print(longtitude)
    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
     let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
     print(myLocation)
     let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
    map.setRegion(region, animated: true)
    self.map.showsUserLocation = true
    
    if startLocation == nil {
        startLocation = userLocation as! CLLocation
        locationManager.stopUpdatingLocation()
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error with location manager: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
