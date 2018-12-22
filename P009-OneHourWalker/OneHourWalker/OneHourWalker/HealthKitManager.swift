//
//  HealthKitManager.swift
//  OneHourWalker
//
//  Created by Matthew Maher on 2/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
        
        let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)
        
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
        
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }
        
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) {
            (success, error) -> Void in
            if completion != nil {
                completion?(success, error)
            }
        }
        
    }
    
    
    
    func getHeight(sampleType: HKSampleType, completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
        
        let distantPastHeight = NSDate.distantPast as Date
        let currentDate = NSDate() as Date
        let lastHeightPredicate = HKQuery.predicateForSamples(withStart: distantPastHeight, end: currentDate, options: [])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let heightQuery = HKSampleQuery(sampleType: sampleType, predicate: lastHeightPredicate, limit: 1, sortDescriptors: [sortDescriptor]) {
            (sampleQuery, results, error) in
            
            if let queryError = error {
                completion?(false, queryError)
                return
            }
            
            let lastHeight = results!.first
            
            if completion != nil {
                completion?((lastHeight != nil), nil)
            }
            
        }
        
        self.healthKitStore.execute(heightQuery)
        
    }
}
