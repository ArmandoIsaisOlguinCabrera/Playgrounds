import Foundation

// MARK: - Protocol with a required property and method
protocol Identifiable {
    var id: String { get }
    func describe()
}

// MARK: - Default implementation using protocol extension
extension Identifiable {
    func describe() {
        print("This object's ID is \(id)")
    }
}

// MARK: - Another protocol
protocol Trackable {
    func track()
}

// MARK: - Default implementation for Trackable
extension Trackable {
    func track() {
        print("Tracking not implemented specifically, using default tracking...")
    }
}

// MARK: - Struct conforming to multiple protocols (Protocol Composition)
struct User: Identifiable, Trackable {
    var id: String
    var name: String

    // Optionally override describe()
    func describe() {
        print("User \(name) has ID \(id)")
    }

    // Optionally override track()
    func track() {
        print("User \(name) is being tracked by GPS.")
    }
}

// MARK: - Function using protocol composition
func monitor(entity: Identifiable & Trackable) {
    entity.describe()
    entity.track()
}

// MARK: - Runtime check for protocol conformance
func checkProtocolCompliance(_ object: Any) {
    if let identifiable = object as? Identifiable {
        print("Object conforms to Identifiable:")
        identifiable.describe()
    } else {
        print("Object does NOT conform to Identifiable.")
    }
}

// MARK: - Usage
let user1 = User(id: "U123", name: "Alice")

// Using composed protocol function
monitor(entity: user1)

// Runtime protocol check
checkProtocolCompliance(user1)

let randomObject = "I am just a string"
checkProtocolCompliance(randomObject)
