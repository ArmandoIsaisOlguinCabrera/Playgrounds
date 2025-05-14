import UIKit
import SwiftUI
import PlaygroundSupport

// MARK: - UIKit UIViewController to Host ActivityViewController
class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let button = UIButton(type: .system)
        button.setTitle("Share Text", for: .normal)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        button.center = view.center
        button.frame = CGRect(x: 100, y: 150, width: 200, height: 50)
        
        view.addSubview(button)
    }
    
    @objc func shareTapped() {
        // Example content to share
        let text = "Hello from my app!"
        
        // Activity View Controller for sharing content
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}

// MARK: - NSUserActivity Example (Handoff or Spotlight)
class ActivityTrackingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUserActivity()
    }

    func createUserActivity() {
        // Create and configure a user activity
        let activity = NSUserActivity(activityType: "com.example.viewing")
        activity.title = "Viewing Item"
        activity.userInfo = ["id": 42]
        activity.isEligibleForHandoff = true
        activity.isEligibleForSearch = true
        activity.becomeCurrent()
        self.userActivity = activity
    }
}

// MARK: - Hosting Both Views
let tabBarController = UITabBarController()
let shareVC = ShareViewController()
shareVC.tabBarItem = UITabBarItem(title: "Share", image: nil, tag: 0)

let activityVC = ActivityTrackingViewController()
activityVC.tabBarItem = UITabBarItem(title: "Activity", image: nil, tag: 1)

tabBarController.viewControllers = [shareVC, activityVC]

// Present the tab bar controller
PlaygroundPage.current.liveView = tabBarController
