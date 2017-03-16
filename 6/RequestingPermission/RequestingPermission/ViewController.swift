//
//  ViewController.swift
//  RequestingPermission
//
//  Created by andyron on 2017/3/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var textView: UITextView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getLocation(sender: UIButton) {
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {  // 当用户没有选择权限，让用户选择
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            let alertController = UIAlertController(title: "定位受限", message: "ab", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            return
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - CLLocationManagerDelegate
    //位置变动时调用
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print("Current location: \(currentLocation)")
        self.textView.text = "当前位置:\(currentLocation)"
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        self.textView.text = "Error \(error)"
    }

}

