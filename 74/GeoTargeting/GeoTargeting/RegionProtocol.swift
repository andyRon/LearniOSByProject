//
//  RegionProtocol.swift
//  GeoTargeting
//
//  Created by andyron on 2017/7/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import Foundation
import CoreLocation

protocol RegionProtocol {
    var coordinate: CLLocation {get}
    var raduis: CLLocationDistance {get}
    var identifier: String {get}
    
    func updateRegion()
}
