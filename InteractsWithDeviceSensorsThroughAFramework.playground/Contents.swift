import SwiftUI
import CoreMotion

// A SwiftUI view that displays accelerometer data
struct MotionSensorExampleView: View {
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("Accelerometer Data:")
            Text("X: \(motionManager.acceleration.x, specifier: "%.2f")")
            Text("Y: \(motionManager.acceleration.y, specifier: "%.2f")")
            Text("Z: \(motionManager.acceleration.z, specifier: "%.2f")")
        }
        .padding()
        .onAppear {
            motionManager.startAccelerometer()
        }
        .onDisappear {
            motionManager.stopAccelerometer()
        }
    }
}

// MotionManager
final class MotionManager: ObservableObject {
    private var manager = CMMotionManager()
    private let updateInterval = 1.0 / 60.0 // 60 Hz update rate

    // Published acceleration property so SwiftUI can observe changes
    @Published var acceleration: CMAcceleration = .init(x: 0, y: 0, z: 0)

    // Starts accelerometer updates and handles new data
    func startAccelerometer() {
        guard manager.isAccelerometerAvailable else {
            print("Accelerometer not available")
            return
        }

        manager.accelerometerUpdateInterval = updateInterval

        manager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let data = data else { return }

            // Extract the value before switching to the main actor
            var acceleration = data.acceleration

            // Update the published property on the main thread
            DispatchQueue.main.async {
                acceleration = acceleration
            }
        }
    }

    // Stops accelerometer updates
    func stopAccelerometer() {
        manager.stopAccelerometerUpdates()
    }
}
