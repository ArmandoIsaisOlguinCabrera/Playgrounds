import UIKit
import SwiftUI
import PlaygroundSupport

// --- UIKit: Custom Button with Layout & Drawing Overriding ---

class CustomButton: UIButton {
    // Overriding the layout and drawing for custom button appearance
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Custom layout: Round the corners and add a custom border
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Custom drawing: Change button title color on draw
        self.setTitleColor(UIColor.white, for: .normal)
    }
}

// Create a custom button instance
let customButton = CustomButton()
customButton.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
customButton.setTitle("Press Me", for: .normal)
customButton.backgroundColor = UIColor.blue

// --- SwiftUI: Creating a Custom Button using ViewModifier ---

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.spring())
    }
}

struct ContentView: View {
    var body: some View {
        Button("Press Me") {
            print("Button Pressed")
        }
        .buttonStyle(CustomButtonStyle())
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

// --- SwiftUI: ViewBuilder for Creating Complex Layout ---

struct CustomView: View {
    var body: some View {
        VStack {
            Text("Welcome to Custom UI Playground")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                Text("This is a custom UI component:")
                    .font(.subheadline)
                
                CustomButtonStyleView()
            }
        }
    }
}

struct CustomButtonStyleView: View {
    var body: some View {
        Button("Click Me") {
            print("Custom button clicked!")
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

// --- UIKit ViewController for Custom UI component display ---

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color for visibility
        view.backgroundColor = .white
        
        // Add the custom button to the view
        view.addSubview(customButton)
    }
}

// --- Combine UIKit and SwiftUI in Playground Live View ---

// UIKit
let viewController = ViewController()
let navigationController = UINavigationController(rootViewController: viewController)

// SwiftUI
let swiftUIContentView = ContentView()

// Combine UIKit and SwiftUI for live preview
PlaygroundPage.current.setLiveView(
    VStack {
        Text("UIKit Custom Button Example")
        customButton // UIKit button displayed in Playground
        Text("SwiftUI Custom Button Example")
        swiftUIContentView // SwiftUI custom button
    }
    .padding()
    .frame(width: 400, height: 600)
)
