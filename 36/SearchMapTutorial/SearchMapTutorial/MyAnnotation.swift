//
//  MyAnnotation.swift
//  SearchMapTutorial
//
//  Created by andyron on 2017/3/28.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String!
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
    
}

