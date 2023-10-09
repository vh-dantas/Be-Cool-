//
//  NotificationsSettings.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 28/09/23.
//

import UserNotifications

func scheduleWaterNotification() {

    
    let content = UNMutableNotificationContent()
    content.title = "Water time"
    content.body = "Don't forget to stay hydrated"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
    let request = UNNotificationRequest(identifier: "waterNotifIdentifier", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully.")
        }
    }
}

func scheduleStretchNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Stretch time"
    content.body = "Do some light stretches of your arms, legs and back"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 180, repeats: true)
    
    let request = UNNotificationRequest(identifier: "stretchNotifIdentifier", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully.")
        }
    }
}

func scheduleWalkNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Walk around"
    content.body = "Try going for a quick 5 minute walk"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: true)
    
    let request = UNNotificationRequest(identifier: "walkNotifIdentifier", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully.")
        }
    }
}
