import Foundation

// Simulating the initialization of the Incognia SDK (In a real project, this would be done in your AppDelegate)
class IncogniaSimulator {
    static var apiKey: String = "YOUR_API_KEY" // Example of handling the API key
    static var userLocation: String = "Unknown"
    static var userBehaviorPattern: String = "Normal"
    
    // Method to initialize the connection with Incognia
    static func initialize() {
        print("Incognia SDK initialized with API key: \(apiKey)")
    }
    
    // Method to simulate location validation
    static func validateLocation(currentLocation: String) -> Bool {
        // Simulating that if the location is "Normal", the system approves it
        userLocation = currentLocation
        print("Validating user location: \(currentLocation)")
        
        // Simulating that a location outside the norm generates a "fraud"
        if currentLocation == "Suspicious Location" {
            return false
        }
        return true
    }
    
    // Method to simulate user behavior validation
    static func validateUserBehavior(behaviorPattern: String) -> Bool {
        userBehaviorPattern = behaviorPattern
        print("Validating user behavior: \(behaviorPattern)")
        
        // If the behavior seems suspicious, we mark it as fraud
        if behaviorPattern == "Abnormal Behavior" {
            return false
        }
        return true
    }
    
    // Method to process the transaction
    static func processTransaction(location: String, behavior: String) -> String {
        // Validate the location first
        if !validateLocation(currentLocation: location) {
            return "Fraud Detected: Suspicious Location"
        }
        
        // Then validate the user behavior
        if !validateUserBehavior(behaviorPattern: behavior) {
            return "Fraud Detected: Abnormal Behavior"
        }
        
        return "Transaction Approved"
    }
}

// Simulating a transaction flow in a Playground
IncogniaSimulator.initialize()

// Simulating a user in a suspicious location with normal behavior
let location = "Suspicious Location"
let behavior = "Normal Behavior"

let result = IncogniaSimulator.processTransaction(location: location, behavior: behavior)
print(result)  // Output: "Fraud Detected: Suspicious Location"

// Now testing with normal behavior and location
let normalBehavior = "Normal Behavior"
let normalLocation = "Normal Location"
let normalResult = IncogniaSimulator.processTransaction(location: normalLocation, behavior: normalBehavior)
print(normalResult)  // Output: "Transaction Approved"
