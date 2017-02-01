//
//  VcMap.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 2/1/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class VcMap: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate
{
   
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var LblETA: UILabel!
    var onRoute:Bool = false;
    
    var firstRouted:Bool = false;

    @IBOutlet weak var MapView: MKMapView!
    static var locationManager: CLLocationManager = CLLocationManager()
    var StartingPoint: CLLocationCoordinate2D?
    
    var tripData:M_Trip!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        MapView.delegate = self
        MapView.showsUserLocation = true
        
        Styler.BorderRad(target: btnStart, Radus: 3, borderWidth: 0)
        Styler.BorderRad(target: LblETA, Radus: 3, borderWidth: 0)
        
        VcMap.locationManager.delegate = self
        VcMap.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            VcMap.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        StartingPoint = CLLocationCoordinate2D(
            latitude: Double(tripData.FromLat!)!
            , longitude: Double(tripData.FromLong!)!)
        getDirections(fromMyLocation: false)
    }
    
    @IBAction func RoutFromMyLocation()
    {
        if onRoute
        {
            onRoute = false
            ShowETA(seconds: 0);
            self.btnStart.setTitle("Start", for: .normal)
            MapView.removeOverlays(MapView.overlays)
        }
        else
        {
            if CLLocationManager.locationServicesEnabled() {
                
                VcMap.locationManager.requestLocation()
            }
        }
        
    }

    func  getDirections(fromMyLocation:Bool)
    {
        
        let request = MKDirectionsRequest()
        
        if #available(iOS 10.0, *) {
            
            if fromMyLocation
            {
                request.source = MKMapItem.forCurrentLocation()
            }
            else
            {
                request.source = MKMapItem(placemark:
                MKPlacemark(coordinate: CLLocationCoordinate2D(
                    latitude: Double(tripData.ToLat!)!
                    , longitude: Double(tripData.ToLong!)!)))
            }
            
            request.destination = MKMapItem(placemark:
                MKPlacemark(coordinate: CLLocationCoordinate2D(
                    latitude: Double(tripData.FromLat!)!
                    , longitude: Double(tripData.FromLong!)!)))
    
        }
        else
        {
            // Fallback on earlier versions
        }//destination!
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response!)
                if self.firstRouted
                {
                    self.onRoute = true
                    self.btnStart.setTitle("Finish", for: .normal)
                }
                else
                {
                    self.firstRouted = true
                }
            }
        })

    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        
        MapView.removeOverlays(MapView.overlays)
        for route in response.routes
        {
            ShowETA(seconds: Int(route.expectedTravelTime))
            
            MapView.add(route.polyline,
                         level: MKOverlayLevel.aboveRoads)
            
            for step in route.steps {
                print(step.instructions)
            }
        }
        

        let region =
            MKCoordinateRegionMakeWithDistance(StartingPoint!,
                                               2000, 2000)
        MapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    // corelocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        StartingPoint = locations[0].coordinate
         self.getDirections(fromMyLocation: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func ShowETA(seconds:Int) -> ()
    {
        let hours = seconds / 3600
        let minutes = seconds / 60 % 60
        let seconds = seconds % 60
       
        LblETA.text = String(format:" ETA: %02i:%02i:%02i", hours, minutes, seconds)
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
