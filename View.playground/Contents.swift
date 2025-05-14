import SwiftUI
import PlaygroundSupport

// MARK: - SwiftUI Preview in Playground
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 1. Customizing appearance
                Text("👋 Hello, SwiftUI!")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // 2. Stack views and safe area
                VStack(alignment: .leading) {
                    Text("🌟 Safe Area Demo")
                        .font(.headline)
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(0..<5) { i in
                                Text("Item \(i)")
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.yellow.opacity(0.3))
                
                // 3. Top-left circle using spacers
                ZStack {
                    Color.purple.opacity(0.1)
                    
                    VStack {
                        HStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 40, height: 40)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(height: 150)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

// MARK: - Hosting the SwiftUI View in a UIKit Playground
PlaygroundPage.current.setLiveView(ContentView())
