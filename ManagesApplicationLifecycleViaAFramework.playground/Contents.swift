import SwiftUI

@main
struct LifecycleApp: App {
    // Environment value to track the scene's lifecycle state
    @Environment(\.scenePhase) private var scenePhase
    
    // Initial app setup
    init() {
        // App-level configuration (e.g. analytics, dependency injection)
        print("App is initializing...")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                print("App became active: Restart tasks or refresh UI")
            case .inactive:
                print("App became inactive: Pause ongoing tasks")
            case .background:
                print("App moved to background: Save state or stop services")
            @unknown default:
                print("Unknown new scene phase")
            }
        }
    }
}

// Main content view
struct ContentView: View {
    var body: some View {
        Text("Lifecycle Manager Example")
            .padding()
    }
}


// MARK: UIKit

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Called when the app has finished launching
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("App launched: Initialize services or configure dependencies here")
        return true
    }

    // Called when the app is about to move from active to inactive state
    func applicationWillResignActive(_ application: UIApplication) {
        print("App will resign active: Pause ongoing tasks")
    }

    // Called when the app enters background
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App entered background: Save data, release shared resources")
    }

    // Called when the app is transitioning from background to foreground
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground: Undo changes made on entering the background")
    }

    // Called when the app has become active again
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App became active: Restart tasks that were paused or not started")
    }

    // Called when the app is about to terminate
    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminate: Save data if appropriate")
    }
}

// MARK: SceneDelegate

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Called when a new scene is created and connected
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        print("Scene connected: Prepare UI here")

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

    // Scene became active
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Scene became active")
    }

    // Scene will resign active
    func sceneWillResignActive(_ scene: UIScene) {
        print("Scene will resign active")
    }

    // Scene entered background
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Scene entered background")
    }

    // Scene entered foreground
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Scene will enter foreground")
    }
}

// MARK: ViewController

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "UIKit Lifecycle Example"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
