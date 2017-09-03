//
//  ViewController.swift
//  StreetView
//
//  Created by andyron on 2017/9/3.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet var panoramaView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GMSServices.provideAPIKey("AIzaSyAUcKfC02Vrt29V6aHs3eGavuGJ5sEpb9U")
        
        panoramaView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.3317134, longitude: -122.0307466))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

