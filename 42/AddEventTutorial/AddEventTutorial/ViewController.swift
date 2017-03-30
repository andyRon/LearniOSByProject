//
//  ViewController.swift
//  AddEventTutorial
//
//  Created by andyron on 2017/3/30.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let eventStore = EKEventStore()
        
        let authorizationStatus = EKEventStore.authorizationStatus(for: .event)
        switch authorizationStatus {
        case .authorized:
            insertEvent(store: eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            
            eventStore.requestAccess(to: .event, completion: {
                [weak self](granted: Bool, error: Error!) in
                if granted {
                    self!.insertEvent(store: eventStore)
                } else {
                    print("Access denied2")
                }
            })
            
        default:
            print("Case Default")
        }
    
    }

    func insertEvent(store: EKEventStore) {
        
        let calendars = store.calendars(for: .event) as! [EKCalendar]
        
        for calendar in calendars {
            // 去日历应用中寻找日历名为"andyron"的日历，并添加事件"New Meeting"
            if calendar.title == "andyron" {
                
                let startDate = NSDate()
                
                let endDate = startDate.addingTimeInterval(7200)
                
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "New Meeting"
                event.startDate = startDate as Date
                event.endDate = endDate as Date
                
                do {
                    try store.save(event, span: .thisEvent)
                    print("⏰ 提醒添加成功")
                } catch let error as NSError {
                    print (error, "⏰ 提醒添加失败")
                }
            }
        }
    }

}

