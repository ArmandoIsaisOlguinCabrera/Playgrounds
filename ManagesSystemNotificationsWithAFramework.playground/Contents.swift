import UIKit
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {

    override init() {
        super.init()
        configureNotification()
    }

    // Request permission to show alerts and sounds
    func configureNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notifications permission granted.")
                self.scheduleLocalNotification()
            } else {
                print("❌ Notifications permission denied.")
            }
        }
    }

    // Schedule a local notification after 5 seconds
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hey there!"
        content.body = "This is a local notification triggered by the app."
        content.sound = UNNotificationSound.default

        // Trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "exampleNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error)")
            } else {
                print("📬 Notification scheduled!")
            }
        }
    }

    // Handle the notification when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        print("🔔 Notification received while app is in foreground.")
        completionHandler([.alert, .sound])
    }
}

// Set up a simple view controller
class NotificationViewController: UIViewController {
    let manager = NotificationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}

import PlaygroundSupport
PlaygroundPage.current.liveView = NotificationViewController()
