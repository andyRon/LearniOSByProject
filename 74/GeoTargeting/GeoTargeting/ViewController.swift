//
//  ViewController.swift
//  GeoTargeting
//
//  Created by andyron on 2017/7/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        setupData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if  authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if authorizationStatus == .denied {
            showAlert("位置服务是禁用的，请在设置中打开。")
        } else if authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupData() {
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            let title = "全季酒店"
            let coordinate = CLLocationCoordinate2DMake(31.1849700000,121.6303200000)
            let regionRadius = 300.0
            
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate
            restaurantAnnotation.title = title
            mapView.addAnnotation(restaurantAnnotation)
            
            
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapView.add(circle)
            
        } else {
            print("不能追踪区域")
        }
    }
    // MARK: - MKMapViewDelegate
    // 画圆
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }

    // MARK:- CLLocationManagerDelegate
    var monitoredRegions: Dictionary<String, NSDate> = [:]
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlert("进入 \(region.identifier)")
        
        monitoredRegions[region.identifier] = NSDate()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert("出了 \(region.identifier)")
        
        monitoredRegions.removeValue(forKey: region.identifier)
    }
    // 位置变化
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       updateRegions()
        print("位置变化了")
    }
    
    
    func updateRegions() {
        
        let regionMaxVisiting = 10.0
        var regionsToDelete: [String] = []
        
        for regionIdentifier in monitoredRegions.keys {
            
            if NSDate().timeIntervalSince(monitoredRegions[regionIdentifier]! as Date) > regionMaxVisiting {
                showAlert("谢谢访问")
                
                regionsToDelete.append(regionIdentifier)
            }
        }
        
        for regionIdentifier in regionsToDelete {
            monitoredRegions.removeValue(forKey: regionIdentifier)
        }
    }
    
    func showAlert(_ title: String) {
        print(title)
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        
    }


}

