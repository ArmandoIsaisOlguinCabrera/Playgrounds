import UIKit
import PlaygroundSupport
import SwiftUI

// MARK: - Global UI Customizations using UIAppearance
// Customize all UIButton instances to have a blue background and white title
UIButton.appearance().backgroundColor = .blue
UIButton.appearance().setTitleColor(.white, for: .normal)

// MARK: - Working with Assets: Adding an image asset
// In this case, you should have an image "logo.png" in your Assets folder (or use any other image name)
let logoImageView = UIImageView(image: UIImage(named: "logo"))
logoImageView.contentMode = .scaleAspectFit
logoImageView.frame = CGRect(x: 100, y: 200, width: 100, height: 100) // Position it on the screen

// MARK: - Creating a Reusable Custom View Modifier
// This modifier is reusable across different views in SwiftUI
struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonStyle())
    }
}

// MARK: - Creating a Simple UIViewController to test UIAppearance and Assets
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the background color
        self.view.backgroundColor = .white

        // Create a button using UIButton, with UIAppearance styles applied
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        self.view.addSubview(button)
        
        // Create a logo image view from assets
        self.view.addSubview(logoImageView)

        // Apply custom reusable button style using SwiftUI's ViewModifier (if applicable)
        // We can't directly use SwiftUI's ViewModifiers in UIKit, so we'll replicate this style here:
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.shadowRadius = 5
    }
}

// MARK: - Locking Appearance in Info.plist
// To lock the appearance and prevent switching to system dark/light mode, set the following in your Info.plist:
// <key>UIUserInterfaceStyle</key>
// <string>Light</string> // or "Dark" to lock the appearance

// MARK: - Show the ViewController in Playground
PlaygroundPage.current.liveView = ViewController()
