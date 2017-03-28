//
//  ViewController.swift
//  SearchMapTutorial
//
//  Created by andyron on 2017/3/28.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    // 121.508983,31.241492
    let initiaLocation = CLLocation(latitude: 30.561504, longitude: 114.365484)
    let searchRadius: CLLocationDistance = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initiaLocation.coordinate, searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        searchInMap()
    }

    

    @IBAction func searchOnValueChanged(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        
        searchInMap()
    }
    
    func searchInMap() {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initiaLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            for item in response!.mapItems as! [MKMapItem] {
                print("Item name = \(item.name)")
                print("Latitude = \(item.placemark.location?.coordinate.latitude)")
                print("longitude = \(item.placemark.location?.coordinate.longitude)")
                
                self.addPinToMapView(title: item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
            }
        }
    }
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print(title, latitude, longitude)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title)
        
        mapView.addAnnotation(annotation)
        
        
    }
}

