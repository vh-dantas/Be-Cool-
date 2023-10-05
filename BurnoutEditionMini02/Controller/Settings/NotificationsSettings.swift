//
//  NotificationsSettings.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 28/09/23.
//

import UserNotifications

class NotificationsSettings {
    func scheduleWaterNotification() {
            
            let content = UNMutableNotificationContent()
            content.title = "Water time"
            content.body = "Don't forget to stay hydrated"
            
            // pega a hora de início e final
            guard let workStartTime = UserDefaults.standard.object(forKey: "workStartTime") as? Date,
                  let workEndTime = UserDefaults.standard.object(forKey: "workEndTime") as? Date else {
                print("Error retrieving work times.")
                return
            }
            
            // pega a data/hora atual do sistema
            let now = Date()
            
            // checa se a hora atual tá dentro do horário de trabalho
            if now >= workStartTime && now <= workEndTime {
                // repete a notificação dentro desse intervalo
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                
                let request = UNNotificationRequest(identifier: "waterNotifIdentifier", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully.")
                    }
                }
            } else {
                print("It's not within the work hours. The notification will not be scheduled.")
            }
        }
    
    func scheduleStretchNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Stretch time"
        content.body = "Do some light stretches of your arms, legs and back"
        
        // Set a repeating time interval trigger for every 10 seconds
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
        
        // Set a repeating time interval trigger for every 10 seconds
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
}
