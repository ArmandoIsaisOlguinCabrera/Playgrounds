import PlaygroundSupport
import SwiftUI

struct AccessibleButtonView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            // Title text with accessibility label and header trait
            Text("Welcome to Accessible App")
                .font(.title)
                .fontWeight(.bold)
                .accessibilityLabel("Welcome Title") // VoiceOver reads this instead of visible text
                .accessibilityAddTraits(.isHeader) // Announces as a header for better navigation
            
            // Button with proper size and accessibility settings
            Button(action: {
                print("Button tapped")
            }) {
                Text("Tap Me")
                    .font(.body)
                    .padding()
                    .frame(minWidth: 100, minHeight: 44) // Ensures touch target size is accessible
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .accessibilityLabel("Perform Action") // Describes the button action
            .accessibilityHint("Double-tap to execute the primary action") // Additional info for VoiceOver
            .accessibilityIdentifier("PrimaryActionButton") // Used in UI tests
            
            // Dynamic type support example
            Text("This text supports Dynamic Type.")
                .font(.body)
                .dynamicTypeSize(.large ... .xxLarge) // Supports text scaling for accessibility
                .accessibilityLabel("Supports Dynamic Type") // Custom label for screen reader
        }
        .padding()
        .background(Color.white)
        .accessibilityElement(children: .contain) // Groups the child elements as one for accessibility
    }
}

// Enable Live View in Playground
PlaygroundPage.current.setLiveView(AccessibleButtonView())
