//
//  ViewController.swift
//  UserNotification
//

import UIKit
import UserNotificationsUI
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [[.alert, .sound, .badge]]) { (granted, error) in
            //Handler error
        }
        UNUserNotificationCenter.current().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonHandlerSendNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "title for the notification"
        content.setValue("YES", forKeyPath: "shouldAlwaysAlertWhileAppIsForeground")
        content.body = "Description of the notification"
        content.badge = 0
        let repeatAction = UNNotificationAction(identifier: "repeat", title: "Repeat", options: [])
        let changeAction = UNTextInputNotificationAction(identifier: "change", title: "Change Message", options: [])
        let category = UNNotificationCategory(identifier: "actionCategory", actions: [repeatAction,changeAction], intentIdentifiers: [], options: [])
        content.categoryIdentifier = "title"
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "GMT")! as TimeZone
        
        let dateSelected = NSDate() as Date
        print(dateSelected)
        
        let intervar = dateSelected.timeIntervalSinceNow + 2.0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervar, repeats: false)
        
        let requestIdentifier = "identifierUserNotification"
        let requst = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(requst) { (error) in
            if(error == nil){
                print("successfully notification added")
            }else{
                print(error?.localizedDescription ?? "")
            }
        }
        
        
        
    }
    
}

