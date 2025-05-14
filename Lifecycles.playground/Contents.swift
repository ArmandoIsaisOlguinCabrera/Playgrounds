import UIKit
import PlaygroundSupport

class LifecycleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("✅ viewDidLoad")
    }

    // Called just before the view is added to the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🔄 viewWillAppear")
    }

    // Called after the view has appeared
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("👀 viewDidAppear")
    }

    // Called just before the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("👋 viewWillDisappear")
    }

    // Called after the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("❌ viewDidDisappear")
    }

    // Called when device orientation or size changes (e.g. rotation)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            print("🔄 Transition to new size: \(size)")
        })
    }

    // Called when size class or traits change (e.g. compact to regular)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("📱 Horizontal Size Class: \(traitCollection.horizontalSizeClass == .compact ? "Compact" : "Regular")")
    }
}

PlaygroundPage.current.liveView = LifecycleViewController()



import SwiftUI

struct LifecycleView: View {
    // Accessing horizontal size class (compact or regular)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var message = "👋 Waiting..."

    var body: some View {
        VStack(spacing: 20) {
            Text("Size Class: \(horizontalSizeClass == .compact ? "Compact" : "Regular")")
                .font(.headline)
            
            Text(message)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        // Called when view appears
        .onAppear {
            print("✅ onAppear called")
            message = "✅ View appeared!"
        }
        // Called when view disappears
        .onDisappear {
            print("❌ onDisappear called")
        }
    }
}

struct ContentView: View {
    var body: some View {
        LifecycleView()
    }
}

import PlaygroundSupport
PlaygroundPage.current.setLiveView(ContentView())
